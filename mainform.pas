unit mainform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvUtil, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    CtyPaper: TAdvStringGrid;
    CboContinent: TComboBox;
    CtyNameText: TEdit;
    ctynameLbl: TLabel;
    Label1: TLabel;
    RadioCode: TRadioButton;
    RadioCty: TRadioButton;
    RadioCurr: TRadioButton;
    Label2: TLabel;
    cbDesc: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure DeclareColumn;
    procedure Filldata;
    procedure FillContinent;
    procedure Button1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses datamodule;
procedure TForm2.FormShow(Sender: TObject);
Var IntIndex:Integer;
begin
  DeclareColumn;
  Filldata;
  FillContinent;
end;



procedure TForm2.FillContinent;
Var i:Integer;
    StrContinent:String;
    BlnExist:Boolean;
    bantuContinent:String;
begin
// if CmbBox empty, get data continent to fill it
if CboContinent.Text = '' then
  begin
    if dm.OpenConnection = True then
      begin
        StrContinent:='SELECT distinct continentName FROM test.apps_countries_detailed WHERE 1 order by continentName ';
      end;
      try
        with dm.FDQuery1 do begin
          SQL.Clear;
          SQL.Add(StrContinent);
          open;
          Active := False;
          Active := True;
          FetchAll;
          if RecordCount <>0 then
            begin
              CboContinent.Items.Append('All Continent');
              for i:= 0 to RecordCount-1 do
                begin
                  CboContinent.Items.Append(FieldByName('continentName').AsString);
                  Next;
                end;
              end;
            end;
      except
    end;
  end;
end;


procedure TForm2.Button1Click(Sender: TObject);
begin
dm.OpenConnection;
end;

procedure TForm2.Filldata;
Var StrSQL:String;
i : Integer;
newCty:String;
begin
  dm.OpenConnection;
  if dm.OpenConnection = True then
    begin
      StrSQL:='SELECT * FROM test.apps_countries_detailed WHERE 1 ';
      if (CboContinent.Text = 'All Continent') or (CboContinent.Text = '') then
      // nothing
      Else
        Begin
            StrSQL:=StrSQL + ' AND continentName = ' + QuotedStr(CboContinent.Text);
        End;
      if CtyNameText.Text = '' then
      // nothing
      Else
        Begin
          newCty:= '%'+CtyNameText.Text+'%';
            StrSQL:=StrSQL + ' AND countryName like ' + QuotedStr(newCty);
        End;

      if RadioCode.Checked = True then
        begin
          StrSQL:=StrSQL + ' Order By countryCode ';
        end
      else if RadioCty.Checked = True then
      begin
        StrSQL:=StrSQL + ' Order By countryName ';
      end
      else if RadioCurr.Checked = True then
      begin
        StrSQL:=StrSQL + ' Order By currencyCode ';
      end
      else
      begin
          StrSQL:=StrSQL + ' Order By countryName ';
      end;

      if cbDesc.Checked = True then
        begin
          StrSQL:=StrSQL + ' Desc ';
        end
      else
      begin
         StrSQL:=StrSQL + ' Asc ';
      end;

    end;
    try
      with dm.FDQuery1 do begin
        SQL.Clear;
        SQL.Add(StrSQL);
        open;
        Active := False;
        Active := True;
        FetchAll;

        if RecordCount<>0 then
          begin

            CtyPaper.RowCount:=RecordCount+2;
            for i:= 0 to RecordCount-1 do
            begin
              CtyPaper.Cells[0,i+1]:=IntToStr(i+1);
              CtyPaper.Cells[1,i+1]:=FieldByName('countryCode').AsString;
              CtyPaper.Cells[2,i+1]:=FieldByName('countryName').AsString;
              CtyPaper.Cells[3,i+1]:=FieldByName('currencyCode').AsString;
              CtyPaper.Cells[4,i+1]:=FieldByName('capital').AsString;
              CtyPaper.Cells[5,i+1]:=FieldByName('continentName').AsString;
              Next;
            end;
          end
        Else
          Begin
            CtyPaper.RowCount:=2;
            For i := 0 to CtyPaper.ColCount do
            begin
              CtyPaper.Cells[i,1]:='';
            end
          End;
      end;

    except
      on e: Exception do
      begin
        MessageDlg('Error while doing query', mtError, [mbOK], 0);
        Exit;
      end;
    end;
end;


procedure TForm2.DeclareColumn;
var i:Integer;
begin


CtyPaper.Clear;
//CtyPaper.ColumnSize.Stretch:= True;
CtyPaper.Cells[0,0]:='No.';
CtyPaper.Cells[1,0]:='Code';
CtyPaper.Cells[2,0]:='Country Name';
CtyPaper.Cells[3,0]:='Currency';
CtyPaper.Cells[4,0]:='Capital';
CtyPaper.Cells[5,0]:='Continent';

CtyPaper.ColWidths[0]:=63;
CtyPaper.ColWidths[1]:=63;
CtyPaper.ColWidths[2]:=300;
CtyPaper.ColWidths[3]:=100;
CtyPaper.ColWidths[4]:=130;
CtyPaper.ColWidths[5]:=100;

with CtyPaper do
  begin
    FixedCols := 1;
  end;
end;


end.
