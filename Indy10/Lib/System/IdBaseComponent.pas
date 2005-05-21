{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  56360: IdBaseComponent.pas
{
{   Rev 1.10    08.11.2004 ã. 20:00:46  DBondzhev
{ changed TObject to &Object
}
{
{   Rev 1.9    07.11.2004 ã. 18:17:54  DBondzhev
{ This contains fix for proper call to unit initialization sections.
}
{
{   Rev 1.8    2004.11.06 10:55:00 PM  czhower
{ Fix for Delphi 2005.
}
{
{   Rev 1.7    2004.10.26 9:07:30 PM  czhower
{ More .NET implicit conversions
}
{
{   Rev 1.6    2004.10.26 7:51:58 PM  czhower
{ Fixed ifdef and renamed TCLRStrings to TIdCLRStrings
}
{
{   Rev 1.5    2004.10.26 7:35:16 PM  czhower
{ Moved IndyCat to CType in IdBaseComponent
}
{
{   Rev 1.4    04.10.2004 13:15:06  Andreas Hausladen
{ Thread Safe Unit initialization
}
{
    Rev 1.3    6/11/2004 8:28:26 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.2    2004.04.16 9:18:34 PM  czhower
{ .NET fix to call initialization sections. Code taken from IntraWeb.
}
{
{   Rev 1.1    2004.02.03 3:15:50 PM  czhower
{ Updates to move to System.
}
{
{   Rev 1.0    2004.02.03 2:28:26 PM  czhower
{ Move
}
{
{   Rev 1.4    2004.01.25 11:35:02 PM  czhower
{ IFDEF fix for .net.
}
{
{   Rev 1.3    2004.01.25 10:56:44 PM  czhower
{ Bug fix for InitComponent at design time.
}
{
{   Rev 1.2    2004.01.20 10:03:20 PM  czhower
{ InitComponent
}
{
{   Rev 1.1    2003.12.23 7:33:00 PM  czhower
{ .Net change.
}
{
{   Rev 1.0    11/13/2002 08:38:26 AM  JPMugaas
}
unit IdBaseComponent;
// Kudzu: This unit is permitted to viloate IFDEF restriction to harmonize
// VCL / .Net difference at the base level.

{$I IdCompilerDefines.inc}

interface

uses
  {$IFDEF DotNet}
  System.ComponentModel.Design.Serialization,
  System.Collections.Specialized,
  System.Threading,
  System.Reflection,
  System.IO, // Necessary else System.IO below is confused with RTL System.
  {$ENDIF}
  Classes,
  IdObjs;

// ***********************************************************
// TIdBaseComponent is the base class for all Indy components.
// ***********************************************************
type
  // TIdInitializerComponent exists to consolidate creation differences between .net and vcl.
  // It looks funny, but because of .net restrictions on constructors we have to do some wierdo
  // stuff to catch both constructors.
  //
  // TIdInitializerComponent implements InitComponent which all components must use to initialize
  // other members instead of overriding constructors.
  TIdInitializerComponent = class(TComponent)
  protected
    {$IFDEF DotNet}
    // This event handler will take care about dynamically loaded assemblies after first initialization.
    class procedure AssemblyLoadEventHandler(sender: &Object; args: AssemblyLoadEventArgs); static;
    class procedure InitializeAssembly(AAssembly: Assembly);
    {$ENDIF}
    // This is here to handle both types of constructor initializations, VCL and .Net.
    // It is not abstract so that not all descendants are required to override it.
    procedure InitComponent; virtual;
  public
    {$IFDEF DotNet}
    // Should not be able to make this create virtual? But if not
    // DCCIL complain in IdIOHandler about possible polymorphics....
    constructor Create; overload; virtual;
    // Must be overriden here - but VCL version will catch offenders
    constructor Create(AOwner: TComponent); overload; override;
    {$ELSE}
    // Statics to prevent overrides. For Create(AOwner) see TIdBaseComponent
    //
    // Create; variant is here to allow calls from VCL the same as from .net
    constructor Create; reintroduce; overload;
    // Must be an override and thus virtual to catch when created at design time
    constructor Create(AOwner: TComponent); overload; override;
    {$ENDIF}
  end;

  {$IFDEF DotNet}
  [RootDesignerSerializerAttribute('', '', False)]
  {$ENDIF}
  // TIdBaseComponent is the base class for all Indy components. Utility components, and other non
  // socket based components typically inherit directly from this. While socket components ineherit
  // from TIdComponent instead as it introduces OnWork, OnStatus, etc.
  TIdBaseComponent = class(TIdInitializerComponent)
  private
    function GetIsLoading: Boolean;
    function GetIsDesignTime: Boolean;
  protected
    property IsLoading: Boolean read GetIsLoading;
    property IsDesignTime: Boolean read GetIsDesignTime;
  public
    // This is here to catch components trying to override at compile time and not let them.
    // This does not work in .net, but we always test in VCL so this will catch it.
    {$IFNDEF DotNet}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    function GetVersion: string;
    //
    property Version: string read GetVersion;

    // These casts are for VB. VB does not support implicit convertors.
    // They are part of this class because its easier to access from .NET
    // instead of going through the namespace.unitname.unit.function syntax
    // that Delphi exports global methods as
    {$IFDEF DotNetDistro}
    function CType(aStream: System.IO.Stream): TStream; overload;
    function CType(aStrings: StringCollection): TIdStrings; overload;
    function CType(aStrings: TIdStrings): StringCollection; overload;
    {$ENDIF}
  published
  end;

implementation

uses
  {$IFDEF DotNet}
  System.Runtime.CompilerServices,
  {$ENDIF}
  IdGlobal;

{$IFDEF DotNet}
var
  GInitsCalled: Integer = 0;
{$ENDIF}

{ TIdInitializerComponent }

constructor TIdInitializerComponent.Create;
begin
  {$IFDEF DotNet}
  inherited Create; // Explicit just in case since are not an override
  InitComponent;
  {$ELSE}
  Create(nil);
  {$ENDIF}
end;

constructor TIdInitializerComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // DCCIL will not call our other create from this one, only .Nets ancestor
  // so InitCopmonent will NOT be called twice.
  InitComponent;
end;

{$IFDEF DotNet}
class procedure TIdInitializerComponent.AssemblyLoadEventHandler(sender: &Object;
  args: AssemblyLoadEventArgs);
begin
  if (args <> nil) then begin
    InitializeAssembly(args.loadedAssembly);
  end;
end;

class procedure TIdInitializerComponent.InitializeAssembly(AAssembly: Assembly);
var
  LTypesList: Array of &Type;
  j: integer;
  UnitType: &Type;
begin
    LTypesList := AAssembly.GetTypes();

    for j := Low(LTypesList) to High(LTypesList) do begin
      UnitType := LTypesList[j];

      // Delphi 9 assemblies
      if (Pos('.Units', UnitType.Namespace) > 0) and (UnitType.Name <> '$map$') then begin
        RuntimeHelpers.RunClassConstructor(UnitType.TypeHandle);
      end;
      // Delphi 8 assemblies
      if UnitType.Name = 'Unit' then begin
        RuntimeHelpers.RunClassConstructor(UnitType.TypeHandle);
      end;
    end;
end;
{$ENDIF}

procedure TIdInitializerComponent.InitComponent;
{$IFDEF DotNet}
var
  LAssemblyList: array of Assembly;
  i: integer;
{$ENDIF}
begin
  {$IFDEF DotNet}
  // With .NET initialization sections are not called unless the unit is referenced. D.NET makes
  // initializations and globals part of a "Unit" class. So init sections wont get called unless
  // the Unit class is used. D8 EXEs are ok, but assemblies (ie VS.NET and probably asms in some
  // cases when used from a D8 EXE) do not call their init sections. So we loop through the list of
  // classes in the assembly, and for each one named Unit we call the class constructor which
  // causes the init section to be called.
  //
  if Interlocked.CompareExchange(GInitsCalled, 1, 0) = 0 then begin
    LAssemblyList := AppDomain.get_CurrentDomain.GetAssemblies;

    // Becouse this can be called few times we have to exclu de every time
    Exclude(AppDomain.get_CurrentDomain.AssemblyLoad, TIdInitializerComponent.AssemblyLoadEventHandler);
    Include(AppDomain.get_CurrentDomain.AssemblyLoad, TIdInitializerComponent.AssemblyLoadEventHandler);

    for i := low(LAssemblyList) to high(LAssemblyList) do begin
      initializeAssembly(LAssemblyList[i]);
    end;
  end;
  {$ENDIF}
end;

{ TIdBaseComponent }

{$IFNDEF DotNet}
constructor TIdBaseComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner); // Explicit just in case since are not an override
end;
{$ENDIF}

{$IFDEF DotNetDistro}
function TIdBaseComponent.CType(aStrings: TIdStrings): StringCollection;
begin
  Result := aStrings;
end;
{$ENDIF}

{$IFDEF DotNetDistro}
function TIdBaseComponent.CType(aStream: System.IO.Stream): TStream;
begin
  Result := TCLRStreamWrapper.Create(aStream);
end;
{$ENDIF}

{$IFDEF DotNetDistro}
function TIdBaseComponent.CType(aStrings: StringCollection): TIdStrings;
begin
  Result := TIdStringList.Create(aStrings);
end;
{$ENDIF}

function TIdBaseComponent.GetIsLoading: Boolean;
begin
  Result := (csLoading in ComponentState);
end;

function TIdBaseComponent.GetIsDesignTime: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

function TIdBaseComponent.GetVersion: string;
begin
  Result := gsIdVersion;
end;

end.
