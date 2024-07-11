unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    Edit3: TEdit;
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
  procedure batal;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a : String;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button4Click(Sender: TObject);
begin
batal;
end;

procedure TForm1.batal;
begin
edit1.SetFocus;
button1.Enabled:=True;
button2.Enabled:=false;
Button3.Enabled:=False;
edit1.Clear;
edit2.Clear;
edit3.clear;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
batal;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
 a:= DataModule2.satuan.Fields[0].AsString;
 edit1.Text:= DataModule2.satuan.Fields[1].AsString;
 edit2.Text:= DataModule2.satuan.Fields[2].AsString;
 Button1.Enabled:=false;
 Button2.Enabled:=true;
 Button3.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
with DataModule2.satuan do
  begin
    SQL.Clear;
    SQL.Add('update satuan set nama="'+edit1.text+'", deskripsi="'+edit2.Text+'" where id="'+a+'"');
    ExecSQL;

    SQL.Clear;
    SQL.Add('select * from satuan');
    Open;
  end;
  showmessage('Data Berhasil di Update!');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if MessageDlg('Apakah Anda Yakin Menghapus Data ini',mtWarning,[mbYes,mbNo],0)=mryes then
  begin
    with DataModule2.satuan do
    begin
    SQL.Clear;
    SQL.Add('delete from satuan where id= "'+a+'"');
    ExecSQL ;

    SQL.Clear;
    SQL.Add('select * from satuan');
    Open;
    end;
  ShowMessage('Data Berhasil Di Delete!');
  end else
    begin
    ShowMessage('Data Batal Dihapus!');
    end;
  batal;
  end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if edit1.Text = '' then
  begin
    MessageDlg('Nama Satuan Tidak Boleh Kosong!',mtError,[mbOK],0);
  end else if edit2.text = '' then
  begin
    MessageDlg('Deskripsi Tidak Boleh Kosong!', mtError, [mbOK], 0);
  end else if DataModule2.satuan.Locate('nama',edit1.Text,[]) then
  begin
  MessageDlg('Nama Satuan '+edit1.Text+' Sudah Ada Didalam Sistem',mtWarning,[mbOK],0)
  end else
  Begin
    with DataModule2.satuan do
    begin
      SQL.Clear;
      SQL.Add('insert into satuan (nama, deskripsi) values("'+edit1.Text+'", "'+edit2.Text+'")');
      ExecSQL ;
      SQL.Clear;
      SQL.Add('select * from satuan');
      Open;
    end;
      ShowMessage('Data Berhasil Disimpan!');
    end;
  batal;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
with DataModule2.satuan do
  begin
    SQL.Clear;
    SQL.Add('select * from satuan where nama like "%' + edit3.Text + '%"');
    Open;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
DataModule2.frxReport1.ShowReport();
end;

end.
