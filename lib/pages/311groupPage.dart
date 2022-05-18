import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

double cellWidth = 70; // размер ячейки таблицы 
int maxNumber = 30;// число строк/столбов 

class PRI311Page extends StatefulWidget //создание новой страницы
{
  const PRI311Page({Key? key}) : super(key: key);
  @override
  State<PRI311Page> createState() => PRI311PageState();
}                 //

class PRI311PageState extends State<PRI311Page> { // этой страницы 
  @override
  Widget build(BuildContext context) {
    return Scaffold(// scaffold - тело страницы
        appBar: AppBar( // верхняя строчка
            title:const Text('PRI311')),
      body: SafeArea( // контейнер
        child:  Table(),
      )
    );
  }
}
class Table extends StatefulWidget{ //создание datagrid
  @override 
  _TableState createState() => _TableState();
}//так сказал встроенный советчик
class _TableState extends State<Table> {
  //передача параметров скролл функционала
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _headController;
  late ScrollController _bodyController;
  @override
     void initState()
      {
    super.initState();//wordkey "super" =обращение к функционалу родительского класса
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
   }
  @override
  void dispose()
   {
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
  @override //закрепление движения за визуальной частью 
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHead(
          scrollController: _headController,
        ),
        Expanded(
          child: TableBody(
            scrollController: _bodyController,
          ),
        ),
      ],
    );
  }
}
class TableBody extends StatefulWidget {
  final ScrollController scrollController;
  TableBody({required this.scrollController,});
  @override
  _TableBodyState createState() => _TableBodyState();
}
class _TableBodyState extends State<TableBody> {//значения тела таблицы
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _firstColumnController;
  late ScrollController _restColumnsController;
  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _firstColumnController = _controllers.addAndGet();
    _restColumnsController = _controllers.addAndGet();
  }
  @override
  void dispose() {
    _firstColumnController.dispose();
    _restColumnsController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Row(
        children: [
          SizedBox(
            width: cellWidth,//// левый фиксированный столбик
             child: ListView(
              controller: _firstColumnController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: List.generate(maxNumber - 1,(index) {
                return TableCell(
                  color: Colors.yellow.withOpacity(0.3),
                  value: index+2, //значение клетки             
                );
              }),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(//возможность перемещения
              controller: widget.scrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                width: (maxNumber - 1) * cellWidth,
                child: ListView(
                  controller: _restColumnsController,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: List.generate(maxNumber - 1, (y) {
                    return Row(
                      children: List.generate(maxNumber - 1, (x) {
                        return TableCell(
                          value: (x+2)*(y+2), color: Colors.blue ,
                        ); }),); }), ),), ),),], ),);}}
class TableCell extends StatelessWidget { //клетки таблицы
   var value;
   Color color;
  TableCell({
    required this.value,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: cellWidth, // основные таблицы и шапка 
      height: cellWidth,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black12,
          width: 0.98,
        ),
      ),
      alignment: Alignment.center,//расположение текста
      child: Text(
        '${value }',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class TableHead extends StatelessWidget {//шапуа таблицы
  final ScrollController scrollController;
  TableHead({
    required this.scrollController,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cellWidth,
      child: Row(
        children: [
          TableCell(
            color: Colors.green.withOpacity(0.3),
            value: 1,
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              //предотвращают выход смещения прокрутки за пределы содержимого.
              scrollDirection: Axis.horizontal,
                 //скролл по горизонтале  
              children: List.generate(maxNumber - 1, (index) {
                return TableCell(
                  color: Colors.yellow.withOpacity(0.3),
                  value: index + 2,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}