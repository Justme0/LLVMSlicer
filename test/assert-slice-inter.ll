; ModuleID = 'assert.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"a != 3\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"assert.c\00", align 1
@__PRETTY_FUNCTION__.foo = private unnamed_addr constant [10 x i8] c"int foo()\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c"a is %d\0A\00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c"ok\00", align 1

; Function Attrs: nounwind uwtable
define i32 @foo() #0 {
start:
  br i1 true, label %entry, label %end

entry:                                            ; preds = %start
  %b = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 3, i32* %a, align 4
  %0 = load i32* %a, align 4
  %cmp = icmp ne i32 %0, 3
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 9, i8* getelementptr inbounds ([10 x i8]* @__PRETTY_FUNCTION__.foo, i32 0, i32 0)) #3
  br label %end
                                                  ; No predecessors!
  br label %cond.end

cond.end:                                         ; preds = %1, %cond.true
  ret i32 undef

end:                                              ; preds = %cond.false, %start
  unreachable
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #1

declare i32 @printf(i8*, ...) #2

declare i32 @puts(i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
start:
  br i1 true, label %entry, label %end

entry:                                            ; preds = %start
  %retval = alloca i32, align 4
  %c = alloca i32, align 4
  ret i32 0

end:                                              ; preds = %start
  unreachable
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.6.1 (tags/RELEASE_361/final)"}
