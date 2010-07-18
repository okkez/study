@str = internal constant [13 x i8] c"hello world\0A\00"

define void @main() nounwind
{
  %temp = call i64 @printf( i8* getelementptr ([13 x i8]* @str, i64 0,i64 0))
  ret void;
}

declare i64 @printf(i8*, ...) nounwind

