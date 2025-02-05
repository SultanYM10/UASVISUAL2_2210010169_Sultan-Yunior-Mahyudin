unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    Label8: TLabel;
    Edit6: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    procedure batal;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: String;

implementation

uses Unit2;

{$R *.dfm}

{ TForm1 }

procedure TForm1.batal;
begin
  Button1.Enabled := True;
  Button2.Enabled := False;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  Edit5.Enabled := False;
  ComboBox1.Enabled := False;
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  ComboBox1.Text := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  batal;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled := False;
  Button2.Enabled := True;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  Edit4.Enabled := True;
  Edit5.Enabled := True;
  ComboBox1.Enabled := True;
  Edit1.SetFocus;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  Edit1.Text := DataModule2.kustomer.Fields[1].AsString;
  Edit2.Text := DataModule2.kustomer.Fields[2].AsString;
  Edit3.Text := DataModule2.kustomer.Fields[3].AsString;
  Edit4.Text := DataModule2.kustomer.Fields[4].AsString;
  Edit5.Text := DataModule2.kustomer.Fields[5].AsString;
  ComboBox1.Text := DataModule2.kustomer.Fields[6].AsString;
  a := DataModule2.kustomer.Fields[0].AsString;

  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  Edit4.Enabled := True;
  Edit5.Enabled := True;
  ComboBox1.Enabled := True;
  Button1.Enabled := False;
  Button2.Enabled := False;
  Button3.Enabled := True;
  Button4.Enabled := True;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  batal;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    MessageDlg('NIK Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit2.Text = '' then
  begin
    MessageDlg('Nama Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit3.Text = '' then
  begin
    MessageDlg('Nomor Telepon Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit4.Text = '' then
  begin
    MessageDlg('Email Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit5.Text = '' then
  begin
    MessageDlg('Alamat Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if ComboBox1.Text = '' then
  begin
    MessageDlg('Pilihan Member Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if DataModule2.kustomer.Locate('nik', Edit1.Text, []) then
  begin
    MessageDlg('NIK ' + Edit1.Text + ' Sudah Ada Didalam Sistem', mtWarning, [mbOK], 0);
    Exit;
  end;

  with DataModule2.kustomer do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO kustomer (nik, nama, telp, email, alamat, member) VALUES (' +
      QuotedStr(Edit1.Text) + ', ' +
      QuotedStr(Edit2.Text) + ', ' +
      QuotedStr(Edit3.Text) + ', ' +
      QuotedStr(Edit4.Text) + ', ' +
      QuotedStr(Edit5.Text) + ', ' +
      QuotedStr(ComboBox1.Text) + ')');
    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT * FROM kustomer');
    Open;
  end;
  ShowMessage('Data Berhasil Disimpan!');
  batal;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if MessageDlg('Apakah Anda Yakin Ingin Menghapus Data ini?', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    with DataModule2.kustomer do
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM kustomer WHERE id = "' + a + '"');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SELECT * FROM kustomer');
      Open;
    end;
    ShowMessage('Data Berhasil DiDelete!');
  end else
  begin
    ShowMessage('Data Batal Dihapus!');
  end;
  batal;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    MessageDlg('NIK Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit2.Text = '' then
  begin
    MessageDlg('Nama Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit3.Text = '' then
  begin
    MessageDlg('Nomor Telepon Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit4.Text = '' then
  begin
    MessageDlg('Email Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit5.Text = '' then
  begin
    MessageDlg('Alamat Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  if ComboBox1.Text = '' then
  begin
    MessageDlg('Pilihan Member Tidak Boleh Kosong!', mtError, [mbOK], 0);
    Exit;
  end;

  with DataModule2.kustomer do
  begin
    SQL.Clear;
    SQL.Add('UPDATE kustomer SET nik = :nik, nama = :nama, telp = :telp, email = :email, alamat = :alamat, member = :member WHERE id = :id');
    ParamByName('nik').AsString := Edit1.Text;
    ParamByName('nama').AsString := Edit2.Text;
    ParamByName('telp').AsString := Edit3.Text;
    ParamByName('email').AsString := Edit4.Text;
    ParamByName('alamat').AsString := Edit5.Text;
    ParamByName('member').AsString := ComboBox1.Text;
    ParamByName('id').AsString := a;
    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT * FROM kustomer');
    Open;
  end;
  ShowMessage('Data Berhasil di Update!');
  batal;
end;

procedure TForm1.Edit6Change(Sender: TObject);
begin
  with DataModule2.kustomer do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM kustomer WHERE nama LIKE "%' + Edit6.Text + '%"');
    Open;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 0 then
  begin
    Label7.Caption := 'Diskon: 10%';
    Label7.Visible := True;
  end
  else if ComboBox1.ItemIndex = 1 then
  begin
    Label7.Caption := 'Diskon: 5%';
    Label7.Visible := True;
  end
  else
  begin
    Label7.Visible := False;
  end;
end;

end.

