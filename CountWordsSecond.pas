PROGRAM CountWordsFirst(INPUT, OUTPUT);
{ Программа вывода в терминал искуственно инициализированного 
  содержимого переменной связного списка, которая хранит какие-то
  слова в формате  (слово, количество) }

CONST
  MaxWords = 10000; { Максимальное кол-во слов в массиве } 
  MaxChars = 100; { Максимальная длина слова 50 символов }

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
  DataWords: DataArrays;   { Переменная массива связных списков }
  ArrayWordCount: INTEGER; { Счетчик количества слов в массиве }
  i, j: INTEGER;           { Счетчики для циклов FOR }

{ Инициализация всех слов пробелами }
PROCEDURE InitialisationWordsArrays(VAR DataArray: DataArrays);
BEGIN
  FOR i := 1 TO MaxWords 
  DO
    BEGIN
      DataArray[i].Count := 0;
      FOR j := 1 TO MaxChars 
      DO
        DataArray[i].Word[j] := ' '
    END 
END;

{ Вывод значений массива связного списка }
PROCEDURE WriteMas(VAR OutFile: TEXT; VAR ArrayWordCount: INTEGER; VAR DataArray: DataArrays);
BEGIN
  FOR i := 1 TO ArrayWordCount
  DO
    BEGIN
      j := 1;
      WHILE (j <= MaxChars) AND (DataArray[i].Word[j] <> ' ') DO
      BEGIN
        WRITE(OutFile, DataArray[i].Word[j]);
        j := j + 1
    END;
    WRITELN(OutFile, ' ', DataArray[i].Count);
  END
END;

FUNCTION FindWordInArray(VAR DataArray: DataArrays; Word: STRING): INTEGER;
VAR
  Find: BOOLEAN; { Найдено слово или нет? } 
  i, j: INTEGER; { Переменные счетчиков }
BEGIN
  IF (Length(Word) = 0) OR (Length(Word) > MaxChars)
  THEN
    BEGIN
      FindWordInArray := -1; { Значение, если слово некорректно }
      EXIT
    END;
  FindWordInArray := 0; { Если слова нет, то вернет 0 }
  FOR i := 1 TO ArrayWordCount
  DO
    BEGIN
      Find := TRUE;
      FOR j := 1 TO Length(Word) // Уточнить можно ли использовать?
      DO
        BEGIN
          IF DataArray[i].Word[j] <> Word[j] // Уточнить можно ли оптимизировать?
          THEN
            BEGIN
              Find := FALSE;
              BREAK
            END 
        END;
      { Пока мы в цикле FOR если слово найдено, то фигачим выход из цикла
        со значением номера найденого слова }
      IF Find 
      THEN
        BEGIN
          FindWordInArray := i;
          EXIT 
        END
    END
END;

{ Добавление слова в массив, с проверкой на дублирование }
PROCEDURE AddWordToArray(VAR DataArray: DataArrays; VAR ArrayWordCount: INTEGER; Word: STRING);
VAR
  Index: INTEGER; { Переменная которая будет хранить положение слова, если оно найдено в массиве }
  j: INTEGER;     { Переменная счетчика }
BEGIN
  Index := FindWordInArray(DataWords, Word);
  IF Index = -1
  THEN
    BEGIN
      WRITELN('Исключение: длина слова некорректна');
      EXIT
    END;

  IF Index = 0
  THEN
    IF (ArrayWordCount >= 0) AND (ArrayWordCount < MaxWords)
    THEN
      BEGIN
        ArrayWordCount := ArrayWordCount + 1;
        FOR j := 1 TO Length(Word)
        DO
          DataArray[ArrayWordCount].Word[j] := Word[j];
        DataArray[ArrayWordCount].Count := 1
      END
    ELSE
      BEGIN
        WRITELN('Исключение: Массив переполнен');
        EXIT
      END
  ELSE
    DataArray[Index].Count := DataArray[Index].Count + 1
END;

BEGIN
  { Описание программы }
  WRITELN;
  WRITELN('[   Тестовая программа вывода слов и их кол-ва в тексте    ]');
  WRITELN('[ Проверка на дублирование слова и добавление его в массив ]');
  WRITELN('                    Приближение - №1.2                      ');
  WRITELN;

  { Инициализация }
  InitialisationWordsArrays(DataWords);
  ArrayWordCount := 0;

  { Мы как-то получаем слова из текстового файла }
  
  { Инкремент счетчика или запись нового слова}
  AddWordToArray(DataWords, ArrayWordCount, 'груша');
  AddWordToArray(DataWords, ArrayWordCount, 'киви');
  AddWordToArray(DataWords, ArrayWordCount, 'лимон');
  AddWordToArray(DataWords, ArrayWordCount, 'яблоко');
  AddWordToArray(DataWords, ArrayWordCount, 'банан');
  AddWordToArray(DataWords, ArrayWordCount, 'мандарин');
  
  { Проверка наличия слов в массиве }
  IF ArrayWordCount > 0
  THEN
    WRITELN('Слово | Кол-во')
  ELSE
    WRITELN('Слова отсутсвуют');

  { Вывод данных }
  WriteMas(OUTPUT, ArrayWordCount, DataWords);
  WRITELN
END.