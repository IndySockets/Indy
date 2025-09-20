{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.4    3/4/2005 2:31:04 PM  JPMugaas
  Fixed some compiler warnings.

  Rev 1.3    24/01/2004 19:29:12  CCostelloe
  Cleaned up warnings

  Rev 1.2    10/17/2003 12:55:00 AM  DSiders
  Added localization comments.

  Rev 1.1    5/28/2003 9:12:06 PM  BGooijen
  ReverseIndian -> ReverseEndian

  Rev 1.0    11/13/2002 07:58:14 AM  JPMugaas
}

{ IdOTPCalculator.pas }

{*===========================================================================*}
{* DESCRIPTION                                                               *}
{*****************************************************************************}
{* PROJECT    : Indy 10                                                      *}
{* AUTHOR     : Bas Gooijen (bas_gooijen@yahoo.com)                          *}
{* MAINTAINER : Bas Gooijen                                                  *}
{*...........................................................................*}
{* DESCRIPTION                                                               *}
{*  OTP password generator                                                   *}
{*                                                                           *}
{*   Implemented according to:                                               *}
{*   http://www.faqs.org/rfcs/rfc1760.html                                   *}
{*   http://www.faqs.org/rfcs/rfc2289.html                                   *}
{*...........................................................................*}
{* HISTORY                                                                   *}
{*     DATE    VERSION  AUTHOR      REASONS                                  *}
{*                                                                           *}
{* 01/11/2002    1.0   Bas Gooijen  Initial start                            *}
{*****************************************************************************}

unit IdOTPCalculator;

interface
{$i IdCompilerDefines.inc}

uses
  IdException;

type
  TIdOTPCalculator = class
  public
    class function GenerateKeyMD4(const ASeed: string; const APassword: string; const ACount: Integer): Int64;
    class function GenerateKeyMD5(const ASeed: string; const APassword: string; const ACount: Integer): Int64;
    class function GenerateKeySHA1(const ASeed: string; const APassword: string; const ACount: Integer): Int64;
    class function GenerateSixWordKey(const AStr, APassword: String; var VKey: String): Boolean; overload;
    class function GenerateSixWordKey(const AMethod, ASeed, APassword: string; const ACount: Integer): string; overload;
    class function IsValidOTPString(const AStr: String): Boolean;
    class function ToHex(const AKey: Int64): string;
    class function ToSixWordFormat(const AKey: Int64): string;
  end;

  EIdOTPError = class(EIdException);
  EIdOTPUnknownMethod = class(EIdOTPError);

implementation

uses
  Classes,
  IdFIPS,
  IdGlobal,
  IdGlobalProtocols,
  IdHash,
  IdHashMessageDigest,
  IdHashSHA,
  IdResourceStringsProtocols,
  SysUtils;

const
  Dictionary: array[0..2047] of string = (
    'A', 'ABE', 'ACE', 'ACT', 'AD', 'ADA', 'ADD',             {do not localize}
    'AGO', 'AID', 'AIM', 'AIR', 'ALL', 'ALP', 'AM', 'AMY',    {do not localize}
    'AN', 'ANA', 'AND', 'ANN', 'ANT', 'ANY', 'APE', 'APS',    {do not localize}
    'APT', 'ARC', 'ARE', 'ARK', 'ARM', 'ART', 'AS', 'ASH',    {do not localize}
    'ASK', 'AT', 'ATE', 'AUG', 'AUK', 'AVE', 'AWE', 'AWK',    {do not localize}
    'AWL', 'AWN', 'AX', 'AYE', 'BAD', 'BAG', 'BAH', 'BAM',    {do not localize}
    'BAN', 'BAR', 'BAT', 'BAY', 'BE', 'BED', 'BEE', 'BEG',    {do not localize}
    'BEN', 'BET', 'BEY', 'BIB', 'BID', 'BIG', 'BIN', 'BIT',   {do not localize}
    'BOB', 'BOG', 'BON', 'BOO', 'BOP', 'BOW', 'BOY', 'BUB',   {do not localize}
    'BUD', 'BUG', 'BUM', 'BUN', 'BUS', 'BUT', 'BUY', 'BY',    {do not localize}
    'BYE', 'CAB', 'CAL', 'CAM', 'CAN', 'CAP', 'CAR', 'CAT',   {do not localize}
    'CAW', 'COD', 'COG', 'COL', 'CON', 'COO', 'COP', 'COT',   {do not localize}
    'COW', 'COY', 'CRY', 'CUB', 'CUE', 'CUP', 'CUR', 'CUT',   {do not localize}
    'DAB', 'DAD', 'DAM', 'DAN', 'DAR', 'DAY', 'DEE', 'DEL',   {do not localize}
    'DEN', 'DES', 'DEW', 'DID', 'DIE', 'DIG', 'DIN', 'DIP',   {do not localize}
    'DO', 'DOE', 'DOG', 'DON', 'DOT', 'DOW', 'DRY', 'DUB',    {do not localize}
    'DUD', 'DUE', 'DUG', 'DUN', 'EAR', 'EAT', 'ED', 'EEL',    {do not localize}
    'EGG', 'EGO', 'ELI', 'ELK', 'ELM', 'ELY', 'EM', 'END',    {do not localize}
    'EST', 'ETC', 'EVA', 'EVE', 'EWE', 'EYE', 'FAD', 'FAN',   {do not localize}
    'FAR', 'FAT', 'FAY', 'FED', 'FEE', 'FEW', 'FIB', 'FIG',   {do not localize}
    'FIN', 'FIR', 'FIT', 'FLO', 'FLY', 'FOE', 'FOG', 'FOR',   {do not localize}
    'FRY', 'FUM', 'FUN', 'FUR', 'GAB', 'GAD', 'GAG', 'GAL',   {do not localize}
    'GAM', 'GAP', 'GAS', 'GAY', 'GEE', 'GEL', 'GEM', 'GET',   {do not localize}
    'GIG', 'GIL', 'GIN', 'GO', 'GOT', 'GUM', 'GUN', 'GUS',    {do not localize}
    'GUT', 'GUY', 'GYM', 'GYP', 'HA', 'HAD', 'HAL', 'HAM',    {do not localize}
    'HAN', 'HAP', 'HAS', 'HAT', 'HAW', 'HAY', 'HE', 'HEM',    {do not localize}
    'HEN', 'HER', 'HEW', 'HEY', 'HI', 'HID', 'HIM', 'HIP',    {do not localize}
    'HIS', 'HIT', 'HO', 'HOB', 'HOC', 'HOE', 'HOG', 'HOP',    {do not localize}
    'HOT', 'HOW', 'HUB', 'HUE', 'HUG', 'HUH', 'HUM', 'HUT',   {do not localize}
    'I', 'ICY', 'IDA', 'IF', 'IKE', 'ILL', 'INK', 'INN',      {do not localize}
    'IO', 'ION', 'IQ', 'IRA', 'IRE', 'IRK', 'IS', 'IT',       {do not localize}
    'ITS', 'IVY', 'JAB', 'JAG', 'JAM', 'JAN', 'JAR', 'JAW',   {do not localize}
    'JAY', 'JET', 'JIG', 'JIM', 'JO', 'JOB', 'JOE', 'JOG',    {do not localize}
    'JOT', 'JOY', 'JUG', 'JUT', 'KAY', 'KEG', 'KEN', 'KEY',   {do not localize}
    'KID', 'KIM', 'KIN', 'KIT', 'LA', 'LAB', 'LAC', 'LAD',    {do not localize}
    'LAG', 'LAM', 'LAP', 'LAW', 'LAY', 'LEA', 'LED', 'LEE',   {do not localize}
    'LEG', 'LEN', 'LEO', 'LET', 'LEW', 'LID', 'LIE', 'LIN',   {do not localize}
    'LIP', 'LIT', 'LO', 'LOB', 'LOG', 'LOP', 'LOS', 'LOT',    {do not localize}
    'LOU', 'LOW', 'LOY', 'LUG', 'LYE', 'MA', 'MAC', 'MAD',    {do not localize}
    'MAE', 'MAN', 'MAO', 'MAP', 'MAT', 'MAW', 'MAY', 'ME',    {do not localize}
    'MEG', 'MEL', 'MEN', 'MET', 'MEW', 'MID', 'MIN', 'MIT',   {do not localize}
    'MOB', 'MOD', 'MOE', 'MOO', 'MOP', 'MOS', 'MOT', 'MOW',   {do not localize}
    'MUD', 'MUG', 'MUM', 'MY', 'NAB', 'NAG', 'NAN', 'NAP',    {do not localize}
    'NAT', 'NAY', 'NE', 'NED', 'NEE', 'NET', 'NEW', 'NIB',    {do not localize}
    'NIL', 'NIP', 'NIT', 'NO', 'NOB', 'NOD', 'NON', 'NOR',    {do not localize}
    'NOT', 'NOV', 'NOW', 'NU', 'NUN', 'NUT', 'O', 'OAF',      {do not localize}
    'OAK', 'OAR', 'OAT', 'ODD', 'ODE', 'OF', 'OFF', 'OFT',    {do not localize}
    'OH', 'OIL', 'OK', 'OLD', 'ON', 'ONE', 'OR', 'ORB',       {do not localize}
    'ORE', 'ORR', 'OS', 'OTT', 'OUR', 'OUT', 'OVA', 'OW',     {do not localize}
    'OWE', 'OWL', 'OWN', 'OX', 'PA', 'PAD', 'PAL', 'PAM',     {do not localize}
    'PAN', 'PAP', 'PAR', 'PAT', 'PAW', 'PAY', 'PEA', 'PEG',   {do not localize}
    'PEN', 'PEP', 'PER', 'PET', 'PEW', 'PHI', 'PI', 'PIE',    {do not localize}
    'PIN', 'PIT', 'PLY', 'PO', 'POD', 'POE', 'POP', 'POT',    {do not localize}
    'POW', 'PRO', 'PRY', 'PUB', 'PUG', 'PUN', 'PUP', 'PUT',   {do not localize}
    'QUO', 'RAG', 'RAM', 'RAN', 'RAP', 'RAT', 'RAW', 'RAY',   {do not localize}
    'REB', 'RED', 'REP', 'RET', 'RIB', 'RID', 'RIG', 'RIM',   {do not localize}
    'RIO', 'RIP', 'ROB', 'ROD', 'ROE', 'RON', 'ROT', 'ROW',   {do not localize}
    'ROY', 'RUB', 'RUE', 'RUG', 'RUM', 'RUN', 'RYE', 'SAC',   {do not localize}
    'SAD', 'SAG', 'SAL', 'SAM', 'SAN', 'SAP', 'SAT', 'SAW',   {do not localize}
    'SAY', 'SEA', 'SEC', 'SEE', 'SEN', 'SET', 'SEW', 'SHE',   {do not localize}
    'SHY', 'SIN', 'SIP', 'SIR', 'SIS', 'SIT', 'SKI', 'SKY',   {do not localize}
    'SLY', 'SO', 'SOB', 'SOD', 'SON', 'SOP', 'SOW', 'SOY',    {do not localize}
    'SPA', 'SPY', 'SUB', 'SUD', 'SUE', 'SUM', 'SUN', 'SUP',   {do not localize}
    'TAB', 'TAD', 'TAG', 'TAN', 'TAP', 'TAR', 'TEA', 'TED',   {do not localize}
    'TEE', 'TEN', 'THE', 'THY', 'TIC', 'TIE', 'TIM', 'TIN',   {do not localize}
    'TIP', 'TO', 'TOE', 'TOG', 'TOM', 'TON', 'TOO', 'TOP',    {do not localize}
    'TOW', 'TOY', 'TRY', 'TUB', 'TUG', 'TUM', 'TUN', 'TWO',   {do not localize}
    'UN', 'UP', 'US', 'USE', 'VAN', 'VAT', 'VET', 'VIE',      {do not localize}
    'WAD', 'WAG', 'WAR', 'WAS', 'WAY', 'WE', 'WEB', 'WED',    {do not localize}
    'WEE', 'WET', 'WHO', 'WHY', 'WIN', 'WIT', 'WOK', 'WON',   {do not localize}
    'WOO', 'WOW', 'WRY', 'WU', 'YAM', 'YAP', 'YAW', 'YE',     {do not localize}
    'YEA', 'YES', 'YET', 'YOU', 'ABED', 'ABEL', 'ABET', 'ABLE',     {do not localize}
    'ABUT', 'ACHE', 'ACID', 'ACME', 'ACRE', 'ACTA', 'ACTS', 'ADAM', {do not localize}
    'ADDS', 'ADEN', 'AFAR', 'AFRO', 'AGEE', 'AHEM', 'AHOY', 'AIDA', {do not localize}
    'AIDE', 'AIDS', 'AIRY', 'AJAR', 'AKIN', 'ALAN', 'ALEC', 'ALGA', {do not localize}
    'ALIA', 'ALLY', 'ALMA', 'ALOE', 'ALSO', 'ALTO', 'ALUM', 'ALVA', {do not localize}
    'AMEN', 'AMES', 'AMID', 'AMMO', 'AMOK', 'AMOS', 'AMRA', 'ANDY', {do not localize}
    'ANEW', 'ANNA', 'ANNE', 'ANTE', 'ANTI', 'AQUA', 'ARAB', 'ARCH', {do not localize}
    'AREA', 'ARGO', 'ARID', 'ARMY', 'ARTS', 'ARTY', 'ASIA', 'ASKS', {do not localize}
    'ATOM', 'AUNT', 'AURA', 'AUTO', 'AVER', 'AVID', 'AVIS', 'AVON', {do not localize}
    'AVOW', 'AWAY', 'AWRY', 'BABE', 'BABY', 'BACH', 'BACK', 'BADE', {do not localize}
    'BAIL', 'BAIT', 'BAKE', 'BALD', 'BALE', 'BALI', 'BALK', 'BALL', {do not localize}
    'BALM', 'BAND', 'BANE', 'BANG', 'BANK', 'BARB', 'BARD', 'BARE', {do not localize}
    'BARK', 'BARN', 'BARR', 'BASE', 'BASH', 'BASK', 'BASS', 'BATE', {do not localize}
    'BATH', 'BAWD', 'BAWL', 'BEAD', 'BEAK', 'BEAM', 'BEAN', 'BEAR', {do not localize}
    'BEAT', 'BEAU', 'BECK', 'BEEF', 'BEEN', 'BEER', 'BEET', 'BELA', {do not localize}
    'BELL', 'BELT', 'BEND', 'BENT', 'BERG', 'BERN', 'BERT', 'BESS', {do not localize}
    'BEST', 'BETA', 'BETH', 'BHOY', 'BIAS', 'BIDE', 'BIEN', 'BILE', {do not localize}
    'BILK', 'BILL', 'BIND', 'BING', 'BIRD', 'BITE', 'BITS', 'BLAB', {do not localize}
    'BLAT', 'BLED', 'BLEW', 'BLOB', 'BLOC', 'BLOT', 'BLOW', 'BLUE', {do not localize}
    'BLUM', 'BLUR', 'BOAR', 'BOAT', 'BOCA', 'BOCK', 'BODE', 'BODY', {do not localize}
    'BOGY', 'BOHR', 'BOIL', 'BOLD', 'BOLO', 'BOLT', 'BOMB', 'BONA', {do not localize}
    'BOND', 'BONE', 'BONG', 'BONN', 'BONY', 'BOOK', 'BOOM', 'BOON', {do not localize}
    'BOOT', 'BORE', 'BORG', 'BORN', 'BOSE', 'BOSS', 'BOTH', 'BOUT', {do not localize}
    'BOWL', 'BOYD', 'BRAD', 'BRAE', 'BRAG', 'BRAN', 'BRAY', 'BRED', {do not localize}
    'BREW', 'BRIG', 'BRIM', 'BROW', 'BUCK', 'BUDD', 'BUFF', 'BULB', {do not localize}
    'BULK', 'BULL', 'BUNK', 'BUNT', 'BUOY', 'BURG', 'BURL', 'BURN', {do not localize}
    'BURR', 'BURT', 'BURY', 'BUSH', 'BUSS', 'BUST', 'BUSY', 'BYTE', {do not localize}
    'CADY', 'CAFE', 'CAGE', 'CAIN', 'CAKE', 'CALF', 'CALL', 'CALM', {do not localize}
    'CAME', 'CANE', 'CANT', 'CARD', 'CARE', 'CARL', 'CARR', 'CART', {do not localize}
    'CASE', 'CASH', 'CASK', 'CAST', 'CAVE', 'CEIL', 'CELL', 'CENT', {do not localize}
    'CERN', 'CHAD', 'CHAR', 'CHAT', 'CHAW', 'CHEF', 'CHEN', 'CHEW', {do not localize}
    'CHIC', 'CHIN', 'CHOU', 'CHOW', 'CHUB', 'CHUG', 'CHUM', 'CITE', {do not localize}
    'CITY', 'CLAD', 'CLAM', 'CLAN', 'CLAW', 'CLAY', 'CLOD', 'CLOG', {do not localize}
    'CLOT', 'CLUB', 'CLUE', 'COAL', 'COAT', 'COCA', 'COCK', 'COCO', {do not localize}
    'CODA', 'CODE', 'CODY', 'COED', 'COIL', 'COIN', 'COKE', 'COLA', {do not localize}
    'COLD', 'COLT', 'COMA', 'COMB', 'COME', 'COOK', 'COOL', 'COON', {do not localize}
    'COOT', 'CORD', 'CORE', 'CORK', 'CORN', 'COST', 'COVE', 'COWL', {do not localize}
    'CRAB', 'CRAG', 'CRAM', 'CRAY', 'CREW', 'CRIB', 'CROW', 'CRUD', {do not localize}
    'CUBA', 'CUBE', 'CUFF', 'CULL', 'CULT', 'CUNY', 'CURB', 'CURD', {do not localize}
    'CURE', 'CURL', 'CURT', 'CUTS', 'DADE', 'DALE', 'DAME', 'DANA', {do not localize}
    'DANE', 'DANG', 'DANK', 'DARE', 'DARK', 'DARN', 'DART', 'DASH', {do not localize}
    'DATA', 'DATE', 'DAVE', 'DAVY', 'DAWN', 'DAYS', 'DEAD', 'DEAF', {do not localize}
    'DEAL', 'DEAN', 'DEAR', 'DEBT', 'DECK', 'DEED', 'DEEM', 'DEER', {do not localize}
    'DEFT', 'DEFY', 'DELL', 'DENT', 'DENY', 'DESK', 'DIAL', 'DICE', {do not localize}
    'DIED', 'DIET', 'DIME', 'DINE', 'DING', 'DINT', 'DIRE', 'DIRT', {do not localize}
    'DISC', 'DISH', 'DISK', 'DIVE', 'DOCK', 'DOES', 'DOLE', 'DOLL', {do not localize}
    'DOLT', 'DOME', 'DONE', 'DOOM', 'DOOR', 'DORA', 'DOSE', 'DOTE', {do not localize}
    'DOUG', 'DOUR', 'DOVE', 'DOWN', 'DRAB', 'DRAG', 'DRAM', 'DRAW', {do not localize}
    'DREW', 'DRUB', 'DRUG', 'DRUM', 'DUAL', 'DUCK', 'DUCT', 'DUEL', {do not localize}
    'DUET', 'DUKE', 'DULL', 'DUMB', 'DUNE', 'DUNK', 'DUSK', 'DUST', {do not localize}
    'DUTY', 'EACH', 'EARL', 'EARN', 'EASE', 'EAST', 'EASY', 'EBEN', {do not localize}
    'ECHO', 'EDDY', 'EDEN', 'EDGE', 'EDGY', 'EDIT', 'EDNA', 'EGAN', {do not localize}
    'ELAN', 'ELBA', 'ELLA', 'ELSE', 'EMIL', 'EMIT', 'EMMA', 'ENDS', {do not localize}
    'ERIC', 'EROS', 'EVEN', 'EVER', 'EVIL', 'EYED', 'FACE', 'FACT', {do not localize}
    'FADE', 'FAIL', 'FAIN', 'FAIR', 'FAKE', 'FALL', 'FAME', 'FANG', {do not localize}
    'FARM', 'FAST', 'FATE', 'FAWN', 'FEAR', 'FEAT', 'FEED', 'FEEL', {do not localize}
    'FEET', 'FELL', 'FELT', 'FEND', 'FERN', 'FEST', 'FEUD', 'FIEF', {do not localize}
    'FIGS', 'FILE', 'FILL', 'FILM', 'FIND', 'FINE', 'FINK', 'FIRE', {do not localize}
    'FIRM', 'FISH', 'FISK', 'FIST', 'FITS', 'FIVE', 'FLAG', 'FLAK', {do not localize}
    'FLAM', 'FLAT', 'FLAW', 'FLEA', 'FLED', 'FLEW', 'FLIT', 'FLOC', {do not localize}
    'FLOG', 'FLOW', 'FLUB', 'FLUE', 'FOAL', 'FOAM', 'FOGY', 'FOIL', {do not localize}
    'FOLD', 'FOLK', 'FOND', 'FONT', 'FOOD', 'FOOL', 'FOOT', 'FORD', {do not localize}
    'FORE', 'FORK', 'FORM', 'FORT', 'FOSS', 'FOUL', 'FOUR', 'FOWL', {do not localize}
    'FRAU', 'FRAY', 'FRED', 'FREE', 'FRET', 'FREY', 'FROG', 'FROM', {do not localize}
    'FUEL', 'FULL', 'FUME', 'FUND', 'FUNK', 'FURY', 'FUSE', 'FUSS', {do not localize}
    'GAFF', 'GAGE', 'GAIL', 'GAIN', 'GAIT', 'GALA', 'GALE', 'GALL', {do not localize}
    'GALT', 'GAME', 'GANG', 'GARB', 'GARY', 'GASH', 'GATE', 'GAUL', {do not localize}
    'GAUR', 'GAVE', 'GAWK', 'GEAR', 'GELD', 'GENE', 'GENT', 'GERM', {do not localize}
    'GETS', 'GIBE', 'GIFT', 'GILD', 'GILL', 'GILT', 'GINA', 'GIRD', {do not localize}
    'GIRL', 'GIST', 'GIVE', 'GLAD', 'GLEE', 'GLEN', 'GLIB', 'GLOB', {do not localize}
    'GLOM', 'GLOW', 'GLUE', 'GLUM', 'GLUT', 'GOAD', 'GOAL', 'GOAT', {do not localize}
    'GOER', 'GOES', 'GOLD', 'GOLF', 'GONE', 'GONG', 'GOOD', 'GOOF', {do not localize}
    'GORE', 'GORY', 'GOSH', 'GOUT', 'GOWN', 'GRAB', 'GRAD', 'GRAY', {do not localize}
    'GREG', 'GREW', 'GREY', 'GRID', 'GRIM', 'GRIN', 'GRIT', 'GROW', {do not localize}
    'GRUB', 'GULF', 'GULL', 'GUNK', 'GURU', 'GUSH', 'GUST', 'GWEN', {do not localize}
    'GWYN', 'HAAG', 'HAAS', 'HACK', 'HAIL', 'HAIR', 'HALE', 'HALF', {do not localize}
    'HALL', 'HALO', 'HALT', 'HAND', 'HANG', 'HANK', 'HANS', 'HARD', {do not localize}
    'HARK', 'HARM', 'HART', 'HASH', 'HAST', 'HATE', 'HATH', 'HAUL', {do not localize}
    'HAVE', 'HAWK', 'HAYS', 'HEAD', 'HEAL', 'HEAR', 'HEAT', 'HEBE', {do not localize}
    'HECK', 'HEED', 'HEEL', 'HEFT', 'HELD', 'HELL', 'HELM', 'HERB', {do not localize}
    'HERD', 'HERE', 'HERO', 'HERS', 'HESS', 'HEWN', 'HICK', 'HIDE', {do not localize}
    'HIGH', 'HIKE', 'HILL', 'HILT', 'HIND', 'HINT', 'HIRE', 'HISS', {do not localize}
    'HIVE', 'HOBO', 'HOCK', 'HOFF', 'HOLD', 'HOLE', 'HOLM', 'HOLT', {do not localize}
    'HOME', 'HONE', 'HONK', 'HOOD', 'HOOF', 'HOOK', 'HOOT', 'HORN', {do not localize}
    'HOSE', 'HOST', 'HOUR', 'HOVE', 'HOWE', 'HOWL', 'HOYT', 'HUCK', {do not localize}
    'HUED', 'HUFF', 'HUGE', 'HUGH', 'HUGO', 'HULK', 'HULL', 'HUNK', {do not localize}
    'HUNT', 'HURD', 'HURL', 'HURT', 'HUSH', 'HYDE', 'HYMN', 'IBIS', {do not localize}
    'ICON', 'IDEA', 'IDLE', 'IFFY', 'INCA', 'INCH', 'INTO', 'IONS', {do not localize}
    'IOTA', 'IOWA', 'IRIS', 'IRMA', 'IRON', 'ISLE', 'ITCH', 'ITEM', {do not localize}
    'IVAN', 'JACK', 'JADE', 'JAIL', 'JAKE', 'JANE', 'JAVA', 'JEAN', {do not localize}
    'JEFF', 'JERK', 'JESS', 'JEST', 'JIBE', 'JILL', 'JILT', 'JIVE', {do not localize}
    'JOAN', 'JOBS', 'JOCK', 'JOEL', 'JOEY', 'JOHN', 'JOIN', 'JOKE', {do not localize}
    'JOLT', 'JOVE', 'JUDD', 'JUDE', 'JUDO', 'JUDY', 'JUJU', 'JUKE', {do not localize}
    'JULY', 'JUNE', 'JUNK', 'JUNO', 'JURY', 'JUST', 'JUTE', 'KAHN', {do not localize}
    'KALE', 'KANE', 'KANT', 'KARL', 'KATE', 'KEEL', 'KEEN', 'KENO', {do not localize}
    'KENT', 'KERN', 'KERR', 'KEYS', 'KICK', 'KILL', 'KIND', 'KING', {do not localize}
    'KIRK', 'KISS', 'KITE', 'KLAN', 'KNEE', 'KNEW', 'KNIT', 'KNOB', {do not localize}
    'KNOT', 'KNOW', 'KOCH', 'KONG', 'KUDO', 'KURD', 'KURT', 'KYLE', {do not localize}
    'LACE', 'LACK', 'LACY', 'LADY', 'LAID', 'LAIN', 'LAIR', 'LAKE', {do not localize}
    'LAMB', 'LAME', 'LAND', 'LANE', 'LANG', 'LARD', 'LARK', 'LASS', {do not localize}
    'LAST', 'LATE', 'LAUD', 'LAVA', 'LAWN', 'LAWS', 'LAYS', 'LEAD', {do not localize}
    'LEAF', 'LEAK', 'LEAN', 'LEAR', 'LEEK', 'LEER', 'LEFT', 'LEND', {do not localize}
    'LENS', 'LENT', 'LEON', 'LESK', 'LESS', 'LEST', 'LETS', 'LIAR', {do not localize}
    'LICE', 'LICK', 'LIED', 'LIEN', 'LIES', 'LIEU', 'LIFE', 'LIFT', {do not localize}
    'LIKE', 'LILA', 'LILT', 'LILY', 'LIMA', 'LIMB', 'LIME', 'LIND', {do not localize}
    'LINE', 'LINK', 'LINT', 'LION', 'LISA', 'LIST', 'LIVE', 'LOAD', {do not localize}
    'LOAF', 'LOAM', 'LOAN', 'LOCK', 'LOFT', 'LOGE', 'LOIS', 'LOLA', {do not localize}
    'LONE', 'LONG', 'LOOK', 'LOON', 'LOOT', 'LORD', 'LORE', 'LOSE', {do not localize}
    'LOSS', 'LOST', 'LOUD', 'LOVE', 'LOWE', 'LUCK', 'LUCY', 'LUGE', {do not localize}
    'LUKE', 'LULU', 'LUND', 'LUNG', 'LURA', 'LURE', 'LURK', 'LUSH', {do not localize}
    'LUST', 'LYLE', 'LYNN', 'LYON', 'LYRA', 'MACE', 'MADE', 'MAGI', {do not localize}
    'MAID', 'MAIL', 'MAIN', 'MAKE', 'MALE', 'MALI', 'MALL', 'MALT', {do not localize}
    'MANA', 'MANN', 'MANY', 'MARC', 'MARE', 'MARK', 'MARS', 'MART', {do not localize}
    'MARY', 'MASH', 'MASK', 'MASS', 'MAST', 'MATE', 'MATH', 'MAUL', {do not localize}
    'MAYO', 'MEAD', 'MEAL', 'MEAN', 'MEAT', 'MEEK', 'MEET', 'MELD', {do not localize}
    'MELT', 'MEMO', 'MEND', 'MENU', 'MERT', 'MESH', 'MESS', 'MICE', {do not localize}
    'MIKE', 'MILD', 'MILE', 'MILK', 'MILL', 'MILT', 'MIMI', 'MIND', {do not localize}
    'MINE', 'MINI', 'MINK', 'MINT', 'MIRE', 'MISS', 'MIST', 'MITE', {do not localize}
    'MITT', 'MOAN', 'MOAT', 'MOCK', 'MODE', 'MOLD', 'MOLE', 'MOLL', {do not localize}
    'MOLT', 'MONA', 'MONK', 'MONT', 'MOOD', 'MOON', 'MOOR', 'MOOT', {do not localize}
    'MORE', 'MORN', 'MORT', 'MOSS', 'MOST', 'MOTH', 'MOVE', 'MUCH', {do not localize}
    'MUCK', 'MUDD', 'MUFF', 'MULE', 'MULL', 'MURK', 'MUSH', 'MUST', {do not localize}
    'MUTE', 'MUTT', 'MYRA', 'MYTH', 'NAGY', 'NAIL', 'NAIR', 'NAME', {do not localize}
    'NARY', 'NASH', 'NAVE', 'NAVY', 'NEAL', 'NEAR', 'NEAT', 'NECK', {do not localize}
    'NEED', 'NEIL', 'NELL', 'NEON', 'NERO', 'NESS', 'NEST', 'NEWS', {do not localize}
    'NEWT', 'NIBS', 'NICE', 'NICK', 'NILE', 'NINA', 'NINE', 'NOAH', {do not localize}
    'NODE', 'NOEL', 'NOLL', 'NONE', 'NOOK', 'NOON', 'NORM', 'NOSE', {do not localize}
    'NOTE', 'NOUN', 'NOVA', 'NUDE', 'NULL', 'NUMB', 'OATH', 'OBEY', {do not localize}
    'OBOE', 'ODIN', 'OHIO', 'OILY', 'OINT', 'OKAY', 'OLAF', 'OLDY', {do not localize}
    'OLGA', 'OLIN', 'OMAN', 'OMEN', 'OMIT', 'ONCE', 'ONES', 'ONLY', {do not localize}
    'ONTO', 'ONUS', 'ORAL', 'ORGY', 'OSLO', 'OTIS', 'OTTO', 'OUCH', {do not localize}
    'OUST', 'OUTS', 'OVAL', 'OVEN', 'OVER', 'OWLY', 'OWNS', 'QUAD', {do not localize}
    'QUIT', 'QUOD', 'RACE', 'RACK', 'RACY', 'RAFT', 'RAGE', 'RAID', {do not localize}
    'RAIL', 'RAIN', 'RAKE', 'RANK', 'RANT', 'RARE', 'RASH', 'RATE', {do not localize}
    'RAVE', 'RAYS', 'READ', 'REAL', 'REAM', 'REAR', 'RECK', 'REED', {do not localize}
    'REEF', 'REEK', 'REEL', 'REID', 'REIN', 'RENA', 'REND', 'RENT', {do not localize}
    'REST', 'RICE', 'RICH', 'RICK', 'RIDE', 'RIFT', 'RILL', 'RIME', {do not localize}
    'RING', 'RINK', 'RISE', 'RISK', 'RITE', 'ROAD', 'ROAM', 'ROAR', {do not localize}
    'ROBE', 'ROCK', 'RODE', 'ROIL', 'ROLL', 'ROME', 'ROOD', 'ROOF', {do not localize}
    'ROOK', 'ROOM', 'ROOT', 'ROSA', 'ROSE', 'ROSS', 'ROSY', 'ROTH', {do not localize}
    'ROUT', 'ROVE', 'ROWE', 'ROWS', 'RUBE', 'RUBY', 'RUDE', 'RUDY', {do not localize}
    'RUIN', 'RULE', 'RUNG', 'RUNS', 'RUNT', 'RUSE', 'RUSH', 'RUSK', {do not localize}
    'RUSS', 'RUST', 'RUTH', 'SACK', 'SAFE', 'SAGE', 'SAID', 'SAIL', {do not localize}
    'SALE', 'SALK', 'SALT', 'SAME', 'SAND', 'SANE', 'SANG', 'SANK', {do not localize}
    'SARA', 'SAUL', 'SAVE', 'SAYS', 'SCAN', 'SCAR', 'SCAT', 'SCOT', {do not localize}
    'SEAL', 'SEAM', 'SEAR', 'SEAT', 'SEED', 'SEEK', 'SEEM', 'SEEN', {do not localize}
    'SEES', 'SELF', 'SELL', 'SEND', 'SENT', 'SETS', 'SEWN', 'SHAG', {do not localize}
    'SHAM', 'SHAW', 'SHAY', 'SHED', 'SHIM', 'SHIN', 'SHOD', 'SHOE', {do not localize}
    'SHOT', 'SHOW', 'SHUN', 'SHUT', 'SICK', 'SIDE', 'SIFT', 'SIGH', {do not localize}
    'SIGN', 'SILK', 'SILL', 'SILO', 'SILT', 'SINE', 'SING', 'SINK', {do not localize}
    'SIRE', 'SITE', 'SITS', 'SITU', 'SKAT', 'SKEW', 'SKID', 'SKIM', {do not localize}
    'SKIN', 'SKIT', 'SLAB', 'SLAM', 'SLAT', 'SLAY', 'SLED', 'SLEW', {do not localize}
    'SLID', 'SLIM', 'SLIT', 'SLOB', 'SLOG', 'SLOT', 'SLOW', 'SLUG', {do not localize}
    'SLUM', 'SLUR', 'SMOG', 'SMUG', 'SNAG', 'SNOB', 'SNOW', 'SNUB', {do not localize}
    'SNUG', 'SOAK', 'SOAR', 'SOCK', 'SODA', 'SOFA', 'SOFT', 'SOIL', {do not localize}
    'SOLD', 'SOME', 'SONG', 'SOON', 'SOOT', 'SORE', 'SORT', 'SOUL', {do not localize}
    'SOUR', 'SOWN', 'STAB', 'STAG', 'STAN', 'STAR', 'STAY', 'STEM', {do not localize}
    'STEW', 'STIR', 'STOW', 'STUB', 'STUN', 'SUCH', 'SUDS', 'SUIT', {do not localize}
    'SULK', 'SUMS', 'SUNG', 'SUNK', 'SURE', 'SURF', 'SWAB', 'SWAG', {do not localize}
    'SWAM', 'SWAN', 'SWAT', 'SWAY', 'SWIM', 'SWUM', 'TACK', 'TACT', {do not localize}
    'TAIL', 'TAKE', 'TALE', 'TALK', 'TALL', 'TANK', 'TASK', 'TATE', {do not localize}
    'TAUT', 'TEAL', 'TEAM', 'TEAR', 'TECH', 'TEEM', 'TEEN', 'TEET', {do not localize}
    'TELL', 'TEND', 'TENT', 'TERM', 'TERN', 'TESS', 'TEST', 'THAN', {do not localize}
    'THAT', 'THEE', 'THEM', 'THEN', 'THEY', 'THIN', 'THIS', 'THUD', {do not localize}
    'THUG', 'TICK', 'TIDE', 'TIDY', 'TIED', 'TIER', 'TILE', 'TILL', {do not localize}
    'TILT', 'TIME', 'TINA', 'TINE', 'TINT', 'TINY', 'TIRE', 'TOAD', {do not localize}
    'TOGO', 'TOIL', 'TOLD', 'TOLL', 'TONE', 'TONG', 'TONY', 'TOOK', {do not localize}
    'TOOL', 'TOOT', 'TORE', 'TORN', 'TOTE', 'TOUR', 'TOUT', 'TOWN', {do not localize}
    'TRAG', 'TRAM', 'TRAY', 'TREE', 'TREK', 'TRIG', 'TRIM', 'TRIO', {do not localize}
    'TROD', 'TROT', 'TROY', 'TRUE', 'TUBA', 'TUBE', 'TUCK', 'TUFT', {do not localize}
    'TUNA', 'TUNE', 'TUNG', 'TURF', 'TURN', 'TUSK', 'TWIG', 'TWIN', {do not localize}
    'TWIT', 'ULAN', 'UNIT', 'URGE', 'USED', 'USER', 'USES', 'UTAH', {do not localize}
    'VAIL', 'VAIN', 'VALE', 'VARY', 'VASE', 'VAST', 'VEAL', 'VEDA', {do not localize}
    'VEIL', 'VEIN', 'VEND', 'VENT', 'VERB', 'VERY', 'VETO', 'VICE', {do not localize}
    'VIEW', 'VINE', 'VISE', 'VOID', 'VOLT', 'VOTE', 'WACK', 'WADE', {do not localize}
    'WAGE', 'WAIL', 'WAIT', 'WAKE', 'WALE', 'WALK', 'WALL', 'WALT', {do not localize}
    'WAND', 'WANE', 'WANG', 'WANT', 'WARD', 'WARM', 'WARN', 'WART', {do not localize}
    'WASH', 'WAST', 'WATS', 'WATT', 'WAVE', 'WAVY', 'WAYS', 'WEAK', {do not localize}
    'WEAL', 'WEAN', 'WEAR', 'WEED', 'WEEK', 'WEIR', 'WELD', 'WELL', {do not localize}
    'WELT', 'WENT', 'WERE', 'WERT', 'WEST', 'WHAM', 'WHAT', 'WHEE', {do not localize}
    'WHEN', 'WHET', 'WHOA', 'WHOM', 'WICK', 'WIFE', 'WILD', 'WILL', {do not localize}
    'WIND', 'WINE', 'WING', 'WINK', 'WINO', 'WIRE', 'WISE', 'WISH', {do not localize}
    'WITH', 'WOLF', 'WONT', 'WOOD', 'WOOL', 'WORD', 'WORE', 'WORK', {do not localize}
    'WORM', 'WORN', 'WOVE', 'WRIT', 'WYNN', 'YALE', 'YANG', 'YANK', {do not localize}
    'YARD', 'YARN', 'YAWL', 'YAWN', 'YEAH', 'YEAR', 'YELL', 'YOGA', {do not localize}
    'YOKE');                                                        {do not localize}

function ReverseEndian(const AInt: UInt32): UInt32; overload;
begin
  Result := ((AInt and $FF000000) shr 24) or
    ((AInt and $00FF0000) shr 8) or
    ((AInt and $0000FF00) shl 8) or
    ((AInt and $000000FF) shl 24);
end;

function ReverseEndian(const AInt64: Int64): Int64; overload;
begin
  Result := ((AInt64 and $00000000FF000000) shr 24) or
    ((AInt64 and $0000000000FF0000) shr 8) or
    ((AInt64 and $000000000000FF00) shl 8) or
    ((AInt64 and $00000000000000FF) shl 24) or
    ((AInt64 and $FF00000000000000) shr 24) or
    ((AInt64 and $00FF000000000000) shr 8) or
    ((AInt64 and $0000FF0000000000) shl 8) or
    ((AInt64 and $000000FF00000000) shl 24);
end;

function Hash4ToInt64(const AHash: TIdBytes): Int64;
var
  LHashRec: T4x4LongWordRecord;
  I: Integer;
begin
  for I := 0 to 3 do begin
    LHashRec[I] := BytesToUInt32(AHash, SizeOf(UInt32)*I);
  end;
  Result := (Int64(LHashRec[0] xor LHashRec[2]) shl 32) or (LHashRec[1] xor LHashRec[3]);
end;

function Hash5ToInt64(const AHash: TIdBytes): Int64;
var
  LHashRec: T5x4LongWordRecord;
  I: Integer;
begin
  for I := 0 to 4 do begin
    LHashRec[I] := BytesToUInt32(AHash, SizeOf(UInt32)*I);
  end;
  Result := (Int64(LHashRec[0] xor LHashRec[2] xor LHashRec[4]) shl 32) or (LHashRec[1] xor LHashRec[3]);
end;

class function TIdOTPCalculator.ToHex(const AKey: Int64): string;
begin
  Result := IntToHex(AKey, 16);
end;

class function TIdOTPCalculator.ToSixWordFormat(const AKey: Int64): string;

  function GetBits(const Afrom: Int64; const AStart: integer; const ACount: integer): word;
  begin
    Result := (Afrom shl AStart) shr (64 - ACount);
  end;

var
  i: Integer;
  LParity: integer;
begin
  for i := 0 to 4 do begin
    Result := Result + Dictionary[GetBits(AKey, i * 11, 11)] + ' ';
  end;
  LParity := 0;
  for i := 0 to 32 do
    inc(LParity, GetBits(AKey, i * 2, 2));
  LParity := LParity and 3;
  Result := Result + Dictionary[GetBits(AKey, 55, 11) + LParity];
end;

class function TIdOTPCalculator.GenerateKeyMD4(const ASeed: string; const APassword: string; const ACount: Integer): Int64;
var
  LMD4: TIdHashMessageDigest4;
  LTmpBytes: TIdBytes;
  I: Integer;
  L64Bit: Int64;
  LTempLongWord: UInt32;
begin
  CheckMD4Permitted;
  LMD4 := TIdHashMessageDigest4.Create;
  try
    L64Bit := Hash4ToInt64(LMD4.HashString(LowerCase(ASeed) + APassword));

    SetLength(LTmpBytes, SizeOf(UInt32)*2);

    for i := 1 to ACount do begin
      L64Bit := ReverseEndian(L64Bit);

      LTempLongWord := (L64Bit shr 32);
      LTempLongWord := ReverseEndian(LTempLongWord);
      CopyTIdUInt32(LTempLongWord, LTmpBytes, 0);

      LTempLongWord := (L64Bit and $FFFFFFFF);
      LTempLongWord := ReverseEndian(LTempLongWord);
      CopyTIdUInt32(LTempLongWord, LTmpBytes, SizeOf(UInt32));

      L64Bit := Hash4ToInt64(LMD4.HashBytes(LTmpBytes));
    end;
  finally
    FreeAndNil(LMD4);
  end;
  Result := ReverseEndian(L64Bit);
end;

class function TIdOTPCalculator.GenerateKeyMD5(const ASeed: string; const APassword: string; const ACount: Integer): Int64;
var
  LMD5: TIdHashMessageDigest5;
  LTmpBytes: TIdBytes;
  I: Integer;
  L64Bit: int64;
  LTempLongWord: UInt32;
begin
  CheckMD5Permitted;
  LMD5 := TIdHashMessageDigest5.Create;
  try
    L64Bit := Hash4ToInt64(LMD5.HashString(LowerCase(ASeed) + APassword));

    SetLength(LTmpBytes, SizeOf(UInt32)*2);

    for i := 1 to ACount do begin
      L64Bit := ReverseEndian(L64Bit);

      LTempLongWord := (L64Bit shr 32);
      LTempLongWord := ReverseEndian(LTempLongWord);
      CopyTIdUInt32(LTempLongWord, LTmpBytes, 0);

      LTempLongWord := (L64Bit and $FFFFFFFF);
      LTempLongWord := ReverseEndian(LTempLongWord);
      CopyTIdUInt32(LTempLongWord, LTmpBytes, SizeOf(UInt32));

      L64Bit := Hash4ToInt64(LMD5.HashBytes(LTmpBytes));
    end;
  finally
    FreeAndNil(LMD5);
  end;
  Result := ReverseEndian(L64Bit);
end;

class function TIdOTPCalculator.GenerateKeySHA1(const ASeed: string; const APassword: string; const ACount: Integer): Int64;
var
  LSHA1: TIdHashSHA1;
  LTmpBytes: TIdBytes;
  I: integer;
  L64Bit: int64;
  LTempLongWord: UInt32;
begin
  LSHA1 := TIdHashSHA1.Create;
  try
    L64Bit := Hash5ToInt64(LSHA1.HashString(LowerCase(ASeed) + APassword));

    SetLength(LTmpBytes, SizeOf(UInt32)*2);

    for i := 1 to ACount do begin
      L64Bit := ReverseEndian(L64Bit);

      LTempLongWord := (L64Bit shr 32);
      CopyTIdUInt32(LTempLongWord, LTmpBytes, 0);

      LTempLongWord := (L64Bit and $FFFFFFFF);
      CopyTIdUInt32(LTempLongWord, LTmpBytes, SizeOf(UInt32));

      L64Bit := Hash5ToInt64(LSHA1.HashBytes(LTmpBytes));
    end;
  finally
    FreeAndNil(LSHA1);
  end;
  Result := L64Bit;
end;

class function TIdOTPCalculator.GenerateSixWordKey(const AStr, APassword: string; var VKey: String): Boolean;
var
  LChallenge: string;
  LChallengeStartPos: Integer;
  LMethod: string;
  LSeed: string;
  LCount: Integer;
begin
  LChallengeStartPos := Pos('otp-', AStr); {do not localize}
  if LChallengeStartPos > 0 then begin
    Inc(LChallengeStartPos, 4); // to remove "otp-"
    LChallenge := Copy(AStr, LChallengeStartPos, $FFFF);
    LMethod := Fetch(LChallenge);
    LCount := IndyStrToInt(Fetch(LChallenge));
    LSeed := Fetch(LChallenge);
    VKey := GenerateSixWordKey(LMethod, LSeed, APassword, LCount);
    Result := True;
  end else begin
    VKey := '';
    Result := False;
  end;
end;

class function TIdOTPCalculator.GenerateSixWordKey(const AMethod, ASeed, APassword: string;
  const ACount: Integer): string;
begin
  // methods are case sensitive
  case PosInStrArray(AMethod, ['md4', 'md5', 'sha1'], True) of
    0: Result := ToSixWordFormat(GenerateKeyMD4(ASeed, APassword, ACount));
    1: Result := ToSixWordFormat(GenerateKeyMD5(ASeed, APassword, ACount));
    2: Result := ToSixWordFormat(GenerateKeySHA1(ASeed, APassword, ACount));
  else
    raise EIdOTPUnknownMethod.Create(RSOTPUnknownMethod);
  end;
end;

class function TIdOTPCalculator.IsValidOTPString(const AStr: string): Boolean;
var
  LChallenge: string;
  LChallengeStartPos: integer;
  LMethod: string;
begin
  LChallengeStartPos := Pos('otp-', AStr);  {do not localize}
  if LChallengeStartPos > 0 then begin
    Inc(LChallengeStartPos, 4); // to remove "otp-"
    LChallenge := Copy(AStr, LChallengeStartPos, $FFFF);
    LMethod := Fetch(LChallenge);
    // methods are case sensitive
    Result := PosInStrArray(LMethod, ['md4', 'md5', 'sha1'], True) > -1;   {do not localize}
  end else begin
    Result := False;
  end;
end;

end.


