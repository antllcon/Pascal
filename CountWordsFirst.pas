PROGRAM CountWordsFirst(INPUT, OUTPUT);
{Программа хранит какое-то слово и 
 выводит его в терминал}

CONST
  MaxWords = 10; { Максимальное кол-во слов в массиве } 
  MaxChars = 50; { Максимальная длина слова }

TYPE 
  { Тип данных связный список,
    состоящий из слова (массив символов от 1 до 50)
    и числа (кол-во повторений слова в тексте) } 
  ListOfWordCounts = RECORD 
                      Word: ARRAY[1 .. MaxChars] OF CHAR;
                      Count: INTEGER;
                    END;

  { Массив связных списоков (формат слово и число) }
  DataArrays = ARRAY[1 .. MaxWords] OF ListOfWordCounts;

VAR
  DataWords: DataArrays; { Переменная массива связных списков}
  i, j: INTEGER;         { счетчики для циклов FOR }

{ Инициализация всех слов пробелами }
PROCEDURE InitialisationWordsArrays(VAR DataArray: DataArrays);
BEGIN
 FOR i := 1 TO MaxWords DO
    FOR j := 1 TO MaxChars DO
      DataArray[i].Word[j] := ' ';
END;

{ Вывод значений массива связного списка }
PROCEDURE WriteMas(VAR OutFile: TEXT; VAR DataArray: DataArrays);
BEGIN
  FOR i := 1 TO MaxWords DO
  BEGIN
    FOR j := 1 TO MaxChars DO
    BEGIN
      IF DataArray[i].Word[j] = ' '
      THEN
        BREAK
      ELSE
        WRITE(OutFile, DataArray[i].Word[j])
    END;
    IF DataArray[i].Count = 0
    THEN
      BREAK
    ELSE
      WRITELN(OutFile, ' ', DataArray[i].Count)
  END
END;

BEGIN
  { Инициализация }
  InitialisationWordsArrays(DataWords);

  { Мы как-то получаем слова из текстового файла
    ищем полученные слова в массиве слов,
    если слово есть, то инкремент счетчика,
    а иначе запись нового в массив }
  
  { Определение первого слова "apple" }
  DataWords[1].Word[1] := 'a';
  DataWords[1].Word[2] := 'p';
  DataWords[1].Word[3] := 'p';
  DataWords[1].Word[4] := 'l';
  DataWords[1].Word[5] := 'e';
  DataWords[1].Count := 1;

  { Определение второго слова "juice" }
  DataWords[2].Word[1] := 'j';
  DataWords[2].Word[2] := 'u';
  DataWords[2].Word[3] := 'i';
  DataWords[2].Word[4] := 'c';
  DataWords[2].Word[5] := 'e';
  DataWords[2].Count := 1;

  { Описание программы }
  WRITELN;
  WRITELN('[ Тестовая программа вывода слов и их кол-ва в тексте ]');
  WRITELN('[          Хранение в формате связного списка         ]');
  WRITELN('                    Приближение - №1                   ');
  WRITELN;
  WRITELN('Слово | Кол-во');

  { Вывод данных }
  WriteMas(OUTPUT, DataWords);
  WRITELN
END.