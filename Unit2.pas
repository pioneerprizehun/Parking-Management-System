unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.SqlExpr, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.VCLUI.Wait, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDConnection1: TFDConnection;
    search: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditCarNum: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Editminpay: TEdit;
    Label3: TLabel;
    Editdaypay: TEdit;
    ComboBox1: TComboBox;
    lblKIND: TLabel;
    Label4: TLabel;
    normalpay: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure searchClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
uses unit1;

procedure TForm2.searchClick(Sender: TObject);
begin
 try
    begin
      with FDConnection1 do begin
      Params.Clear;
      Params.Add('DriverID=MySQL');
      Params.Add('Server=127.0.0.1');
      Params.Add('Port=3306');
      Params.Add('Database=parkinglot');
      Params.Add('User_Name=root');
      Params.Add('Password=root');

      Params.Add('CharacterSet=utf8');

      Open;
      end;
      with FDQuery1 do begin
      SQL.Clear;
      SQL.Add('set @cnt = 0;');
      SQL.Add('update ledger set ledger.num = @cnt := @cnt+1;');   //삭제로 인한 번호밀림현상 num값 재정렬
      SQL.Add('select * from ledger');
            open;
      end;
end;
 finally


 end;
 end;



procedure TForm2.Button1Click(Sender: TObject);

begin

if ComboBox1.Text = '일반주차' then
begin
    try

      with FDConnection1 do begin
      Params.Clear;
      Params.Add('DriverID=MySQL');
      Params.Add('Server=127.0.0.1');
      Params.Add('Port=3306');
      Params.Add('Database=parkinglot');
      Params.Add('User_Name=root');
      Params.Add('Password=root');
      Params.Add('CharacterSet=utf8');
      Open;
     end;
        with FDQuery1 do begin
        SQL.Clear;
        SQL.Add('INSERT INTO ledger(carnum,startTIME,kind,pay)');
        SQL.Add('VALUE(:carN,:StartT,:kind,:pay);');
        Params.ParamByName('carN').AsString := EditCarNum.Text;
        Params.ParamByName('StartT').AsString := formatDateTime('yyyy-mm-dd hh:mm:ss', now);
        Params.ParamByName('kind').AsString := ComboBox1.Text;  //콤보박스의 텍스트로 설정
        Params.ParamByName('pay').AsString := normalpay.Text;  //일반주차 기본금액 으로설정
        execsql;
        showMessage('추가완료');
        SQL.Clear;
        SQL.Add('select * from ledger');
        open;
       end;
     finally



   end;
end;

if ComboBox1.Text = '일일주차' then
begin
      try

        with FDConnection1 do begin
        Params.Clear;
        Params.Add('DriverID=MySQL');
        Params.Add('Server=127.0.0.1');
        Params.Add('Port=3306');
        Params.Add('Database=parkinglot');
        Params.Add('User_Name=root');
        Params.Add('Password=root');
        Params.Add('CharacterSet=utf8');
        Open;
       end;
         with FDQuery1 do begin
          SQL.Clear;
          SQL.Add('INSERT INTO ledger(carnum,startTIME,kind,pay)');
          SQL.Add('VALUE(:carN,:StartT,:kind,:pay);');
          Params.ParamByName('carN').AsString := EditCarNum.Text;
          Params.ParamByName('StartT').AsString := formatDateTime('yyyy-mm-dd hh:mm:ss', now);
          Params.ParamByName('kind').AsString := ComboBox1.Text;  //콤보박스의 텍스트로 설정
          Params.ParamByName('pay').AsString := Editdaypay.Text;  //일일주차금액으로 설정
          execsql;
          showMessage('추가완료');
          SQL.Clear;
          SQL.Add('select * from ledger');
          open;
         end;
       finally



     end;
end;

end;

procedure TForm2.Button2Click(Sender: TObject);
var
startend:string;
start1,end1:string;
begin
 try

    with FDConnection1 do begin
    Params.Clear;
    Params.Add('DriverID=MySQL');
    Params.Add('Server=127.0.0.1');
    Params.Add('Port=3306');
    Params.Add('Database=parkinglot');
    Params.Add('User_Name=root');
    Params.Add('Password=root');
    Params.Add('CharacterSet=utf8');
    Open;
   end;
       with FDQuery1 do begin
      SQL.Clear;
      SQL.Add('select * from ledger');
      SQL.Add('where carnum = :carN;');        //차번호 검색
      Params.ParamByName('carN').AsString := EditCarNum.text;   //차번호는 EditCarNum.tEXT에서 가져온다


      open;
      end;

  //일반주차계산식
  // 일반주차계산식 ((endTIME - startTIME))/60-30)/10*400
 lblKIND.Caption := dbGrid1.Fields[4].AsString;
 if lblKIND.Caption = '일반주차' then
 begin
  try
    with FDQuery1 do
    begin
    SQL.Clear;
    SQL.Add('select * from ledger;');
    SQL.Add('UPDATE ledger SET endTIME = now() WHERE Carnum =:carT;'); // 차번호를 받아와 endTIME 업데이트를해준다.
    SQL.ADD('UPDATE ledger SET endstart = ROUND(((unix_timestamp(endTIME)-unix_timestamp(startTIME))/60-30)/10*400,-2) WHERE carnum =:carT;');
    {ROUND(xxx,-2)를 이용해 십원단위 절사}
    Params.ParamByName('carT').AsString := EditCarNum.text;   //차번호는 EditCarNum.tEXT에서 가져온다
    showmessage('출차완료 금액을확인해주세요');
    open;
    SQL.Add('select * from ledger');
    SQL.Add('where carnum = :carT;');
    open;
    end;

  finally

  end;
  end;  //if 일반 주차 begin 종료

 lblKIND.Caption := dbGrid1.Fields[4].AsString;
 if lblKIND.Caption = '일일주차' then
 begin
  try
    with FDQuery1 do
    begin
     SQL.Clear;
    SQL.Add('select * from ledger;');
    SQL.Add('UPDATE ledger SET endTIME = now() WHERE Carnum =:carT;'); // 차번호를 받아와 endTIME 업데이트를해준다.
    SQL.ADD('UPDATE ledger SET endstart = ROUND(((unix_timestamp(endTIME)-unix_timestamp(startTIME))/60-30)/10*400,-2) WHERE carnum =:carT;');
    {ROUND(xxx,-2)를 이용해 십원단위 절사}
    Params.ParamByName('carT').AsString := EditCarNum.text;   //차번호는 EditCarNum.tEXT에서 가져온다
    showmessage('출차완료 금액을확인해주세요');
    open;
    SQL.Add('select * from ledger');
    SQL.Add('where carnum = :carT;');
    open;
    end;
  finally

  end; //if 일일주차 begin 종료




 end;
 finally

 end;
 end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.close;
end;

end.
