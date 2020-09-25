class APPCODE{
//JAVA : public static final 대신해서 작성
//하드 코딩 방지 및 고정변수 관리
  String def_Title(int i) => 'ToDo_' + i.toString();
  String def_Message(int i ) => i.toString()+'st Thing You Should do';
}