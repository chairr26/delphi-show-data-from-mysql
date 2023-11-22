program Project2;

uses
  Vcl.Forms,
  mainform in 'mainform.pas' {Form2},
  datamodule in 'datamodule.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
