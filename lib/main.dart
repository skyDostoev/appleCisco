//開発環境： https://future-architect.github.io/articles/20211221a/
//発行： https://qiita.com/yu0819ki/items/2c8f4c9e32dbecca0590

// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Copyright (c) 2022.
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Cisco',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Apple Cisco'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool _bInit = false;
  
  void _init(){if(_bInit){}else{
      _counter =0;
        _lastKey="";
         _num = ConstC.numC;
        _alpha0 = PwdC.formatS(ConstC.alphaC.substring(0,13),4);
        _alpha1 = PwdC.formatS(ConstC.alphaC.substring(13,26),4);
        _bInit=true;
  }}
  int _counter = 0;
  String _num = "";
  String _alpha0 ="";
  String _alpha1 = "";
  String _debug = "";
  String _lastKey = "";
  
    var _keyTEC = TextEditingController();
  
  void _mainF(String s) {_main(s,"F");}
  void _mainBa() {_main(_keyTEC.text,"Ba");}
  void _mainBr() {_main(_keyTEC.text,"Br");}
  
  void _main(String s,String FBar) {
    s=s.substring(0,s.length<6?s.length:6);
    s=s.toLowerCase();
    setState(() {
     
      try{
        _counter=
          _lastKey!=s?0:
          FBar=="F"?0:
          FBar=="Ba"?++_counter:
          _counter==0?_counter:
          --_counter;
        List<String> L3=genPwd(s,_counter);
        _num=L3[0];      
       
        _lastKey = s;  
        _debug = "";
      }catch(e){   
        _debug="$e";
        _bInit=false;
        _init();
      }
      _keyTEC.text=_lastKey;
      
        
    } );
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),         
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
              Text(
                'Kyoto Tokyo',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 16),
              Text(
                'London Paris'
                ,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),

           Text(
              "$_counter",
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '$_num',
              style: Theme.of(context).textTheme.headline4,
            ),
            
             FractionallySizedBox(
                widthFactor: 0.5,
                child: TextField(
                  style: TextStyle(
                  fontSize: 18/*テキストのサイズ*/,),
                  controller: _keyTEC,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your key and hit Enter'),
                  onSubmitted: (String value) {
                   _mainF(value);
                  },
                ),
              ),
            Text(
              '$_debug',
              style: Theme.of(context).textTheme.bodyText1,
            ),
             Text(
              "\n$_alpha0\n$_alpha1",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _mainBa,
            tooltip: 'Increment the version number.',
            child: const Icon(Icons.add),
      ),   FloatingActionButton(
            onPressed: _mainBr,
            tooltip: 'Decrement the version number.',
            child: const Icon(Icons.remove),
      )]
      ),
    );
  }
}


List<String> genPwd(String key,int ver){
      key=key.trim();

      assert2(
        //How to validate email addresses: https://www.regular-expressions.info/email.html
       RegExp(r"^[a-z0-9_]{3,6}$").hasMatch(key),
      "wrong format as 1: $key"
      );  
      key="$key$ver";
      Map<String,List<String>> m = PwdC.main1(key);
      return m.values.map((e)=>PwdC.format(e,4)).toList();
}

void assert2(bool b,String msg){
  if(!b){throw  Exception(msg);}
}

class ConstC{
    
  static List<String> genList(String s) {
    List<String> L=[];
    for(int i=0;i<s.length;i++){
      L.add(s[i]);
    }
    return L;
  }
  static String get numC => "0123456789";
  static String get num16C => "0123456789abcdef";
  static String get alphaC => "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static String get symC=> "!#\$%&@=-+*/()[]{}<>;:,.\"'`^~?_|\\";
}


class PwdC{
  static Map<String,List<String>> main1(String key){
    final m=ParmC.main(key);
    Map<String,List<String>> re={};
    for(var mk in ["n","a","s"]){
      var L;
      switch(mk){
       case "a":{L=ConstC.alphaC;break;}
      case "n":{L=ConstC.numC;break;}
      case "s":{L=ConstC.symC;break;}
        default:{throw Exception();}
      }
      final tmpL = ConstC.genList(L);
      re[mk] = main2(m,mk,tmpL);
    }
      return re;  
  }
  static List<String> main2(Map<String,List<int>> ML32,String mapKey,List<String>L) { 
    List<int>? L32=ML32[mapKey];
    if(L32!=null){
    final L32w = L32.where((e) =>e <= L.length-1 ).toList();
    List<String> re=[];
    for(var i=0;i<L32w.length;i++){
      re.add(L[L32w[i]]);
    }
    return re;    
    }
    else{throw Exception();}
  }
  
  static String format(List<String> L,int u){
      String re="";
      var s="";
      for(var x in L){
        if(s.length<u){s+=x;}else{    re = "$re $s";s=x;}
      }
      re = "$re $s";
      return re.trim();
  }
  static String formatS(String S,int u){
    final L=S.characters.map((e)=>"$e").toList();
    return format(L,u);
  }
}
class ParmC{
  static const c32=32;
  static Map<String,List<int>> main(String key) {
    Map<String,List<int>> re={};
     for (var c in ["a","n","s"]){
     final L32=parmL("$c$key");
     re[c]=L32;
     }
     return re;
  }
  /*static List<int> genKey(String key){
    List<int> L=[];
    for (var i=0;i<c32/2;i++){
      L.add(("@"*i+key).hashCode%c32);
    }
    return L;
  }*/
static List<int> parmL(String key){
  const c32=32;
  final L=List<int>.generate(c32, (index) => -1);
  final R=List<int>.generate(c32, (index) => -1);
  int y=0;
  for(var i=0;i<c32;i++){
      final xi = "$key${y++}".hashCode%c32;
      
      if(L[xi]<0){L[xi]=1;R[i]=xi;}
      else{i--;}
  }
  return R;
}
}