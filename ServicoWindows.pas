unit ServicoWindows;

interface

uses
  System.SysUtils,
  Winapi.Windows,
  Winapi.WinSvc;

type
  TServicoWindows = class(TObject)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    class function Iniciar(const ANomeServico: string): Boolean;
    class function Parar(const ANomeServico: string): Boolean;
    class function Reiniciar(const ANomeServico: string): Boolean;
    class function IsAtivo(const ANomeServico: string): Boolean;
    class function Existe(const ANomeServico: string): Boolean;
    class function Status(const ANomeServico: string): DWORD;
    class function StatusToString(const AStatus: DWORD): string;
    { public declarations }
  published
    { published declarations }
  end;

implementation

{ TServicoWindows }

class function TServicoWindows.Existe(const ANomeServico: string): Boolean;
var
  SCM:     SC_HANDLE;
  Service: SC_HANDLE;
begin
  Result := False;
  SCM    := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);

  if SCM = 0 then
    Exit;

  try
    Service := OpenService(SCM, PChar(ANomeServico), SERVICE_QUERY_STATUS);

    if Service = 0 then
      Exit;

    try
      Result := True;
    finally
      CloseServiceHandle(Service);
    end;
  finally
    CloseServiceHandle(SCM);
  end;
end;

class function TServicoWindows.Iniciar(const ANomeServico: string): Boolean;
var
  SCM:     SC_HANDLE;
  Service: SC_HANDLE;
  Args:    PWideChar;
begin
  Result := False;
  Args   := nil;

  SCM := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if SCM = 0 then
    Exit;

  try
    Service := OpenService(
      SCM,
      PChar(ANomeServico),
      SERVICE_START or SERVICE_QUERY_STATUS
      );

    if Service = 0 then
      Exit;

    try
      Result := StartService(Service, 0, Args);

      if not Result then
        Result := GetLastError = ERROR_SERVICE_ALREADY_RUNNING;

    finally
      CloseServiceHandle(Service);
    end;

  finally
    CloseServiceHandle(SCM);
  end;
end;

class function TServicoWindows.IsAtivo(const ANomeServico: string): Boolean;
begin
  Result := Status(ANomeServico) = SERVICE_RUNNING;
end;

class function TServicoWindows.Parar(const ANomeServico: string): Boolean;
var
  SCM:     SC_HANDLE;
  Service: SC_HANDLE;
  Status:  SERVICE_STATUS;
begin
  Result := False;

  SCM := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if SCM = 0 then
    Exit;

  try
    Service := OpenService(
      SCM,
      PChar(ANomeServico),
      SERVICE_STOP or SERVICE_QUERY_STATUS
      );

    if Service = 0 then
      Exit;

    try
      if ControlService(Service, SERVICE_CONTROL_STOP, Status) then
        Result := True
      else
        Result := GetLastError = ERROR_SERVICE_NOT_ACTIVE;

    finally
      CloseServiceHandle(Service);
    end;

  finally
    CloseServiceHandle(SCM);
  end;
end;

class function TServicoWindows.Reiniciar(const ANomeServico: string): Boolean;
var
  Inicio: UInt64;
begin
  Result := False;

  if not Parar(ANomeServico) then
    Exit;

  Inicio := GetTickCount64;

  while Status(ANomeServico) <> SERVICE_STOPPED do
  begin
    Sleep(200);

    if GetTickCount64 - Inicio > 30000 then
      Exit;
  end;

  Result := Iniciar(ANomeServico);
end;

class function TServicoWindows.Status(const ANomeServico: string): DWORD;
var
  SCM:           SC_HANDLE;
  Service:       SC_HANDLE;
  ServiceStatus: SERVICE_STATUS;
begin
  Result := 0;
  SCM    := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);

  if SCM = 0 then
    Exit;

  try
    Service := OpenService(SCM, PChar(ANomeServico), SERVICE_QUERY_STATUS);

    if Service = 0 then
      Exit;

    try
      if QueryServiceStatus(Service, ServiceStatus) then
        Result := ServiceStatus.dwCurrentState;
    finally
      CloseServiceHandle(Service);
    end;
  finally
    CloseServiceHandle(SCM);
  end;
end;

class function TServicoWindows.StatusToString(const AStatus: DWORD): string;
begin
  case AStatus of
    SERVICE_STOPPED:          Result := 'Serviço parado';
    SERVICE_START_PENDING:    Result := 'Serviço iniciando';
    SERVICE_STOP_PENDING:     Result := 'Serviço parando';
    SERVICE_RUNNING:          Result := 'Serviço em execução';
    SERVICE_CONTINUE_PENDING: Result := 'Serviço continuando';
    SERVICE_PAUSE_PENDING:    Result := 'Serviço pausando';
    SERVICE_PAUSED:           Result := 'Serviço pausado';
  else
    Result := 'Status desconhecido';
  end;
end;

end.
