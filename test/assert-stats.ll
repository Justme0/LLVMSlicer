; ModuleID = 'assert.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"a != b\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"assert.c\00", align 1
@__PRETTY_FUNCTION__.foo = private unnamed_addr constant [10 x i8] c"int foo()\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c"a is %d\0A\00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c"ok\00", align 1
@__ai_init_functions = internal constant [1 x i8*] [i8* bitcast (i32 ()* @main to i8*)]

; Function Attrs: nounwind uwtable
define i32 @foo() #0 {
entry:
  %b = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 77, i32* %b, align 4
  %0 = load i32* %b, align 4
  %inc = add nsw i32 %0, 1
  store i32 %inc, i32* %b, align 4
  store i32 3, i32* %a, align 4
  %1 = load i32* %a, align 4
  %2 = load i32* %b, align 4
  %cmp = icmp ne i32 %1, %2
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 9, i8* getelementptr inbounds ([10 x i8]* @__PRETTY_FUNCTION__.foo, i32 0, i32 0)) #3
  unreachable
                                                  ; No predecessors!
  br label %cond.end

cond.end:                                         ; preds = %3, %cond.true
  %4 = load i32* %a, align 4
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i32 0, i32 0), i32 %4)
  %call1 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @.str3, i32 0, i32 0))
  %5 = load i32* %b, align 4
  ret i32 %5
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #1

declare i32 @printf(i8*, ...) #2

declare i32 @puts(i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 @foo()
  store i32 %call, i32* %c, align 4
  ret i32 0
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.6.1 (tags/RELEASE_361/final)"}
