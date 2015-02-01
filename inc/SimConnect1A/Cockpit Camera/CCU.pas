{ 25/05/2007 10:50:46 (GMT+1:00) > [Akadamia] checked in   }
{ 25/05/2007 10:29:05 (GMT+1:00) > [Akadamia] checked out /}
{ 14/02/2007 08:28:14 (GMT+0:00) > [Akadamia] checked in   }
{ 14/02/2007 08:28:00 (GMT+0:00) > [Akadamia] checked out /}
{ 12/02/2007 10:11:08 (GMT+0:00) > [Akadamia] checked in   }
{ 08/02/2007 14:12:18 (GMT+0:00) > [Akadamia] checked in   }
{-----------------------------------------------------------------------------
 Unit Name: CCU
 Author:    ken.adam
 Date:      15-Jan-2007
 Purpose:   Translation of Cockpit Camera example to Delphi
            Press the < and > keys (actually the , and . keys, as there is 
            no use of the shift key) to rotate the pilot's view
 History:
-----------------------------------------------------------------------------}
unit CCU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ToolWin, ActnMan, ActnCtrls, XPStyleActnCtrls,
  ActnList, ComCtrls, SimConnect, StdActns;
const
  // Define a user message for message driven version of the example
  WM_USER_SIMCONNECT = WM_USER + 2;
type

  // Use enumerated types to create unique IDs as required
  TGroupId = (Group0);
  TEventID = (EventCameraRight, EventCameraLeft);
  TInputId = (Input0);

  // The form
  TCockpitCameraForm = class(TForm)
    StatusBar: TStatusBar;
    ActionManager: TActionManager;
    ActionToolBar: TActionToolBar;
    Images: TImageList;
    Memo: TMemo;
    StartPoll: TAction;
    FileExit: TFileExit;
    StartEvent: TAction;
    procedure StartPollExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SimConnectMessage(var Message: TMessage); message
      WM_USER_SIMCONNECT;
    procedure StartEventExecute(Sender: TObject);
  private
    { Private declarations }
    RxCount: integer; // Count of Rx messages
    Quit: boolean; // True when signalled to quit
    hSimConnect: THandle; // Handle for the SimConection
  public
    { Public declarations }
    procedure DispatchHandler(pData: PSimConnectRecv; cbData: DWORD; pContext:
      Pointer);
  end;

var
  CockpitCameraForm: TCockpitCameraForm;

implementation

resourcestring
  StrRx6d = 'Rx: %6d';
var
  cameraBank: single = 0.0;

function normalize180(v: single): single;
begin
  while (v < -180.0) do v := v + 360.0;
  while (v > 180.0) do v := v - 360.0;
  Result := v;
end;

{$R *.dfm}

  {-----------------------------------------------------------------------------
    Procedure: MyDispatchProc
    Wraps the call to the form method in a simple StdCall procedure
    Author:    ken.adam
    Date:      11-Jan-2007
    Arguments:
      pData: PSimConnectRecv
      cbData: DWORD
      pContext: Pointer
  -----------------------------------------------------------------------------}

procedure MyDispatchProc(pData: PSimConnectRecv; cbData: DWORD; pContext:
  Pointer); stdcall;
begin
  CockpitCameraForm.DispatchHandler(pData, cbData, pContext);
end;

{-----------------------------------------------------------------------------
  Procedure: DispatchHandler
  Handle the Dispatched callbacks in a method of the form. Note that this is
  used by both methods of handling the interface.
  Author:    ken.adam
  Date:      11-Jan-2007
  Arguments:
    pData: PSimConnectRecv
    cbData: DWORD
    pContext: Pointer
-----------------------------------------------------------------------------}

procedure TCockpitCameraForm.DispatchHandler(pData: PSimConnectRecv; cbData:
  DWORD;
  pContext: Pointer);
var
  hr: HRESULT;
  Evt: PSimconnectRecvEvent;
  OpenData: PSimConnectRecvOpen;
begin
  // Maintain a display of the message count
  Inc(RxCount);
  StatusBar.Panels[1].Text := Format(StrRx6d, [RxCount]);
  // Only keep the last 200 lines in the Memo
  while Memo.Lines.Count > 200 do
    Memo.Lines.Delete(0);
  // Handle the various types of message
  case TSimConnectRecvId(pData^.dwID) of
    SIMCONNECT_RECV_ID_OPEN:
      begin
        StatusBar.Panels[0].Text := 'Opened';
        OpenData := PSimConnectRecvOpen(pData);
        with OpenData^ do
        begin
          Memo.Lines.Add('');
          Memo.Lines.Add(Format('%s %1d.%1d.%1d.%1d', [szApplicationName,
            dwApplicationVersionMajor, dwApplicationVersionMinor,
              dwApplicationBuildMajor, dwApplicationBuildMinor]));
          Memo.Lines.Add(Format('%s %1d.%1d.%1d.%1d', ['SimConnect',
            dwSimConnectVersionMajor, dwSimConnectVersionMinor,
              dwSimConnectBuildMajor, dwSimConnectBuildMinor]));
          Memo.Lines.Add('');
        end;
      end;
    SIMCONNECT_RECV_ID_EVENT:
      begin
        evt := PSimconnectRecvEvent(pData);
        case TEventId(evt^.uEventID) of
          EventCameraRight:
            begin
              cameraBank := normalize180(cameraBank + 5.0);
              hr := SimConnect_CameraSetRelative6DOF(hSimConnect, 0.0, 0.0,
                0.0, SIMCONNECT_CAMERA_IGNORE_FIELD,
                  SIMCONNECT_CAMERA_IGNORE_FIELD,
                cameraBank);
              Memo.Lines.Add(Format('Camera Bank = %f', [cameraBank]));
            end;
          EventCameraLeft:
            begin
              cameraBank := normalize180(cameraBank - 5.0);
              hr := SimConnect_CameraSetRelative6DOF(hSimConnect, 0.0, 0.0,
                0.0, SIMCONNECT_CAMERA_IGNORE_FIELD,
                  SIMCONNECT_CAMERA_IGNORE_FIELD,
                cameraBank);
              Memo.Lines.Add(Format('Camera Bank = %f', [cameraBank]));
            end;
        end;
      end;
    SIMCONNECT_RECV_ID_QUIT:
      begin
        Quit := True;
        StatusBar.Panels[0].Text := 'FS X Quit';
      end
  else
    Memo.Lines.Add(Format('Unknown dwID: %d', [pData.dwID]));
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: FormCloseQuery
  Ensure that we can signal "Quit" to the busy wait loop
  Author:    ken.adam
  Date:      11-Jan-2007
  Arguments: Sender: TObject var CanClose: Boolean
  Result:    None
-----------------------------------------------------------------------------}

procedure TCockpitCameraForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Quit := True;
  CanClose := True;
end;

{-----------------------------------------------------------------------------
  Procedure: FormCreate
  We are using  run-time dynamic loading of SimConnect.dll, so that the program
  will execute and fail gracefully if the DLL does not exist.
  Author:    ken.adam
  Date:      11-Jan-2007
  Arguments:
    Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}

procedure TCockpitCameraForm.FormCreate(Sender: TObject);
begin
  if InitSimConnect then
    StatusBar.Panels[2].Text := 'SimConnect.dll Loaded'
  else
  begin
    StatusBar.Panels[2].Text := 'SimConnect.dll NOT FOUND';
    StartPoll.Enabled := False;
    StartEvent.Enabled := False;
  end;
  Quit := False;
  hSimConnect := 0;
  StatusBar.Panels[0].Text := 'Not Connected';
  RxCount := 0;
  StatusBar.Panels[1].Text := Format(StrRx6d, [RxCount]);
end;

{-----------------------------------------------------------------------------
  Procedure: SimConnectMessage
  This uses CallDispatch, but could probably avoid the callback and use
  SimConnect_GetNextDispatch instead.
  Author:    ken.adam
  Date:      11-Jan-2007
  Arguments:
    var Message: TMessage
-----------------------------------------------------------------------------}

procedure TCockpitCameraForm.SimConnectMessage(var Message: TMessage);
begin
  SimConnect_CallDispatch(hSimConnect, MyDispatchProc, nil);
end;

{-----------------------------------------------------------------------------
  Procedure: StartEventExecute
  Opens the connection for Event driven handling. If successful sets up the data
  requests and hooks the system event "SimStart".
  Author:    ken.adam
  Date:      11-Jan-2007
  Arguments:
    Sender: TObject
-----------------------------------------------------------------------------}

procedure TCockpitCameraForm.StartEventExecute(Sender: TObject);
var
  hr: HRESULT;
begin
  if (SUCCEEDED(SimConnect_Open(hSimConnect, 'Cockpit Camera', Handle,
    WM_USER_SIMCONNECT, 0, 0))) then
  begin
    StatusBar.Panels[0].Text := 'Connected';
    // Define private events
    hr := SimConnect_MapClientEventToSimEvent(hSimConnect,
      Ord(EventCameraRight));
    hr := SimConnect_MapClientEventToSimEvent(hSimConnect,
      Ord(EventCameraLeft));
     hr := SimConnect_AddClientEventToNotificationGroup(hSimConnect, Ord(GROUP0),
      Ord(EventCameraRight));
    hr := SimConnect_AddClientEventToNotificationGroup(hSimConnect, Ord(GROUP0),
      Ord(EventCameraLeft));
     hr := SimConnect_SetNotificationGroupPriority(hSimConnect, Ord(GROUP0),
      SIMCONNECT_GROUP_PRIORITY_HIGHEST);
         // Map the keys , and . keys to the private events
    hr := SimConnect_MapInputEventToClientEvent(hSimConnect, Ord(INPUT0),
      'VK_PERIOD', Ord(EventCameraRight));
    hr := SimConnect_MapInputEventToClientEvent(hSimConnect, Ord(INPUT0),
      'VK_COMMA', Ord(EventCameraLeft));
     hr := SimConnect_SetInputGroupState(hSimConnect, Ord(INPUT0),
      Ord(SIMCONNECT_STATE_ON));
    StartEvent.Enabled := False;
    StartPoll.Enabled := False;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: StartPollExecute
  Opens the connection for Polled access. If successful sets up the data
  requests and hooks the system event "SimStart", and then loops indefinitely
  on CallDispatch.
  Author:    ken.adam
  Date:      11-Jan-2007
  Arguments:
    Sender: TObject
-----------------------------------------------------------------------------}

procedure TCockpitCameraForm.StartPollExecute(Sender: TObject);
var
  hr: HRESULT;
begin
  if (SUCCEEDED(SimConnect_Open(hSimConnect, 'Set Data', 0, 0, 0, 0))) then
  begin
    StatusBar.Panels[0].Text := 'Connected';
    // Define private events
    hr := SimConnect_MapClientEventToSimEvent(hSimConnect,
      Ord(EventCameraRight));
    hr := SimConnect_MapClientEventToSimEvent(hSimConnect,
      Ord(EventCameraLeft));
     hr := SimConnect_AddClientEventToNotificationGroup(hSimConnect, Ord(GROUP0),
      Ord(EventCameraRight));
    hr := SimConnect_AddClientEventToNotificationGroup(hSimConnect, Ord(GROUP0),
      Ord(EventCameraLeft));
     hr := SimConnect_SetNotificationGroupPriority(hSimConnect, Ord(GROUP0),
      SIMCONNECT_GROUP_PRIORITY_HIGHEST);
         // Map the keys , and . keys to the private events
    hr := SimConnect_MapInputEventToClientEvent(hSimConnect, Ord(INPUT0),
      'VK_PERIOD', Ord(EventCameraRight));
    hr := SimConnect_MapInputEventToClientEvent(hSimConnect, Ord(INPUT0),
      'VK_COMMA', Ord(EventCameraLeft));
     hr := SimConnect_SetInputGroupState(hSimConnect, Ord(INPUT0),
      Ord(SIMCONNECT_STATE_ON));
    StartEvent.Enabled := False;
    StartPoll.Enabled := False;
    while not Quit do
    begin
      SimConnect_CallDispatch(hSimConnect, MyDispatchProc, nil);
      Application.ProcessMessages;
      Sleep(1);
    end;
    hr := SimConnect_Close(hSimConnect);
  end;
end;

end.

