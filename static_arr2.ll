; ModuleID = 'optimized.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@fpstt = internal unnamed_addr global i32 0
@fp_status.0 = internal unnamed_addr global i8 0
@stack = internal global [4194304 x i32] zeroinitializer, align 16
@onUnfallback = common local_unnamed_addr global i1 false

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define internal fastcc void @helper_fldl_ST0(i64 noundef %0) unnamed_addr #0 {
._crit_edge:
  %1 = load i32, i32* @fpstt, align 16
  %.pre = and i64 %0, 4503599627370495
  %.pre1 = and i64 %0, 9218868437227405312
  %phi.cmp = icmp ne i64 %.pre1, 9218868437227405312
  %phi.cmp3 = icmp eq i64 %.pre, 0
  %2 = or i1 %phi.cmp, %phi.cmp3
  br i1 %2, label %float64_to_floatx80.exit, label %3

3:                                                ; preds = %._crit_edge
  %4 = and i64 %0, 9221120237041090560
  %5 = icmp ne i64 %4, 9218868437227405312
  %6 = and i64 %0, 2251799813685247
  %7 = icmp eq i64 %6, 0
  %8 = or i1 %5, %7
  br i1 %8, label %float64_to_floatx80.exit, label %.sink.split.i

.sink.split.i:                                    ; preds = %3
  %9 = load i8, i8* @fp_status.0, align 1
  %10 = or i8 %9, 1
  store i8 %10, i8* @fp_status.0, align 1
  br label %float64_to_floatx80.exit

float64_to_floatx80.exit:                         ; preds = %.sink.split.i, %3, %._crit_edge
  %11 = add i32 %1, 7
  %12 = and i32 %11, 7
  store i32 %12, i32* @fpstt, align 16
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn writeonly
define internal fastcc void @helper_fninit() unnamed_addr #1 {
  store i32 0, i32* @fpstt, align 16
  ret void
}

; Function Attrs: naked noinline
declare dso_local i32 @printf(i8* noundef, ...) local_unnamed_addr #2

; Function Attrs: mustprogress nounwind uwtable
define internal x86_fastcallcc i64 @helper_stub_trampoline(i32 inreg noundef %0, i32 inreg noundef %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #3 {
  %5 = alloca double, align 8
  %6 = tail call { i32, i32 } asm "movl    %esp, %ebx\0A\09movl    $2, %esp\0A\09calll   *$3\0A\09movl    %ebx, %esp", "={ax},={dx},r,r,{cx},{dx},~{ebx},~{dirflag},~{fpsr},~{flags}"(i32 %2, i32 %3, i32 %0, i32 %1) #10
  %7 = extractvalue { i32, i32 } %6, 0
  %8 = extractvalue { i32, i32 } %6, 1
  %9 = bitcast double* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %9) #8
  call void asm "fstpl   $0", "=*m,~{dirflag},~{fpsr},~{flags}"(double* nonnull elementtype(double) %5) #8
  %10 = load double, double* %5, align 8, !tbaa !6
  %11 = fptoui double %10 to i64
  call fastcc void @helper_fldl_ST0(i64 noundef %11) #11
  %12 = zext i32 %8 to i64
  %13 = shl nuw i64 %12, 32
  %14 = zext i32 %7 to i64
  %15 = or i64 %13, %14
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %9) #8
  ret i64 %15
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: norecurse nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, i8** noundef %1, i8** noundef %2) local_unnamed_addr #5 {
  %4 = tail call i32 asm "pushf\0A\09popl $0", "=r,~{dirflag},~{fpsr},~{flags}"() #10
  tail call fastcc void @helper_fninit() #11
  %5 = ptrtoint i8** %2 to i32
  store i32 %5, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194303), align 4, !tbaa !10
  %6 = ptrtoint i8** %1 to i32
  store i32 %6, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194302), align 8, !tbaa !10
  store i32 %0, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194301), align 4, !tbaa !10
  %7 = tail call i8* @llvm.returnaddress(i32 0)
  %8 = ptrtoint i8* %7 to i32
  store i32 %8, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194300), align 16, !tbaa !10
  tail call fastcc void @Func_main(i32 ptrtoint (i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194300) to i32)) #8
  ret i32 0
}

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i8* @llvm.returnaddress(i32 immarg) #6

; Function Attrs: nofree nosync nounwind
define internal fastcc { i32, i32 } @Func_initializeArray(i32 %arg_esp, i32 %arg_ebp) unnamed_addr #7 !retregs !12 {
Func_8049180.exit.i:
  %tmp2_v.i5.i = add i32 %arg_esp, -4
  %0 = inttoptr i32 %tmp2_v.i5.i to i32*
  store i32 %arg_ebp, i32* %0, align 4
  %tmp0_v.i7.i = add i32 %arg_esp, -12
  %tmp2_v1.i8.i = add i32 %arg_esp, 8
  %1 = inttoptr i32 %tmp2_v1.i8.i to i32*
  %2 = load i32, i32* %1, align 4
  %3 = icmp slt i32 %2, 10
  br i1 %3, label %BB_804919B.i, label %.exit

BB_804919B.i:                                     ; preds = %Func_8049180.exit.i
  %tmp15_v3.i.i = mul i32 %2, %2
  %tmp2_v6.i.i = add i32 %arg_esp, 4
  %4 = inttoptr i32 %tmp2_v6.i.i to i32*
  %5 = load i32, i32* %4, align 4
  %tmp4_v10.i.i = shl i32 %2, 2
  %tmp2_v11.i.i = add i32 %5, %tmp4_v10.i.i
  %6 = inttoptr i32 %tmp2_v11.i.i to i32*
  store i32 %tmp15_v3.i.i, i32* %6, align 4
  %7 = load i32, i32* %4, align 4
  %8 = load i32, i32* %1, align 4
  %tmp0_v16.i.i = add i32 %8, 1
  %9 = inttoptr i32 %tmp0_v.i7.i to i32*
  store i32 %7, i32* %9, align 4
  %tmp2_v17.i.i = add i32 %arg_esp, -8
  %10 = inttoptr i32 %tmp2_v17.i.i to i32*
  store i32 %tmp0_v16.i.i, i32* %10, align 4
  %tmp2_v18.i.i = add i32 %arg_esp, -16
  %11 = inttoptr i32 %tmp2_v18.i.i to i32*
  store i32 134517184, i32* %11, align 4
  %12 = tail call fastcc { i32, i32 } @Func_initializeArray(i32 %tmp2_v18.i.i, i32 %tmp2_v.i5.i)
  %13 = extractvalue { i32, i32 } %12, 0
  br label %.exit

.exit:                                            ; preds = %BB_804919B.i, %Func_8049180.exit.i
  %r_esp.0 = phi i32 [ %13, %BB_804919B.i ], [ %tmp0_v.i7.i, %Func_8049180.exit.i ]
  %tmp0_v.i.i = add i32 %r_esp.0, 8
  %14 = inttoptr i32 %tmp0_v.i.i to i32*
  %15 = load i32, i32* %14, align 4
  %tmp4_v3.i.i = add i32 %r_esp.0, 16
  %mrv = insertvalue { i32, i32 } undef, i32 %tmp4_v3.i.i, 0
  %mrv1 = insertvalue { i32, i32 } %mrv, i32 %15, 1
  ret { i32, i32 } %mrv1
}

; Function Attrs: nounwind
define internal fastcc i32 @Func_printArray(i32 %arg_esp, i32 %arg_ebp) unnamed_addr #8 !retregs !13 {
Func_80491D0.exit.i:
  %tmp2_v.i6.i = add i32 %arg_esp, -4
  %0 = inttoptr i32 %tmp2_v.i6.i to i32*
  store i32 %arg_ebp, i32* %0, align 4
  %tmp0_v.i8.i = add i32 %arg_esp, -28
  %tmp2_v1.i9.i = add i32 %arg_esp, 8
  %1 = inttoptr i32 %tmp2_v1.i9.i to i32*
  %2 = load i32, i32* %1, align 4
  %3 = icmp slt i32 %2, 10
  br i1 %3, label %BB_80491EB.i, label %.exit

BB_80491EB.i:                                     ; preds = %Func_80491D0.exit.i
  %tmp2_v1.i.i = add i32 %arg_esp, 4
  %4 = inttoptr i32 %tmp2_v1.i.i to i32*
  %5 = load i32, i32* %4, align 4
  %tmp4_v.i3.i = shl i32 %2, 2
  %tmp2_v5.i.i = add i32 %5, %tmp4_v.i3.i
  %6 = inttoptr i32 %tmp2_v5.i.i to i32*
  %7 = load i32, i32* %6, align 4
  %8 = inttoptr i32 %tmp0_v.i8.i to i32*
  store i32 134520840, i32* %8, align 4
  %tmp2_v7.i.i = add i32 %arg_esp, -24
  %9 = inttoptr i32 %tmp2_v7.i.i to i32*
  store i32 %2, i32* %9, align 4
  %tmp2_v8.i.i = add i32 %arg_esp, -20
  %10 = inttoptr i32 %tmp2_v8.i.i to i32*
  store i32 %7, i32* %10, align 4
  %tmp2_v9.i.i = add i32 %arg_esp, -32
  %11 = inttoptr i32 %tmp2_v9.i.i to i32*
  store i32 134517261, i32* %11, align 4
  %12 = tail call x86_fastcallcc i64 @helper_stub_trampoline(i32 inreg noundef %2, i32 inreg noundef 134520840, i32 noundef %tmp0_v.i8.i, i32 noundef ptrtoint (i32 (i8*, ...)* @printf to i32)) #11, !funcname !14
  %13 = load i32, i32* %4, align 4
  %14 = load i32, i32* %1, align 4
  %tmp0_v3.i.i = add i32 %14, 1
  store i32 %13, i32* %8, align 4
  store i32 %tmp0_v3.i.i, i32* %9, align 4
  store i32 134517282, i32* %11, align 4
  %15 = tail call fastcc i32 @Func_printArray(i32 %tmp2_v9.i.i, i32 %tmp2_v.i6.i)
  br label %.exit

.exit:                                            ; preds = %BB_80491EB.i, %Func_80491D0.exit.i
  %r_esp.0 = phi i32 [ %15, %BB_80491EB.i ], [ %tmp0_v.i8.i, %Func_80491D0.exit.i ]
  %tmp4_v3.i.i = add i32 %r_esp.0, 32
  ret i32 %tmp4_v3.i.i
}

; Function Attrs: norecurse nounwind
define internal fastcc void @Func_main(i32 %arg_esp) unnamed_addr #9 !retregs !13 {
  %tmp2_v.i2.i = add i32 %arg_esp, -4
  %1 = inttoptr i32 %tmp2_v.i2.i to i32*
  store i32 0, i32* %1, align 4
  %tmp0_v.i.i = add i32 %arg_esp, -60
  %tmp2_v1.i4.i = add i32 %arg_esp, -8
  %2 = inttoptr i32 %tmp2_v1.i4.i to i32*
  store i32 0, i32* %2, align 4
  %tmp2_v2.i5.i = add i32 %arg_esp, -48
  %3 = inttoptr i32 %tmp0_v.i.i to i32*
  store i32 %tmp2_v2.i5.i, i32* %3, align 4
  %tmp2_v3.i.i = add i32 %arg_esp, -56
  %4 = inttoptr i32 %tmp2_v3.i.i to i32*
  store i32 0, i32* %4, align 4
  %tmp2_v4.i.i = add i32 %arg_esp, -64
  %5 = inttoptr i32 %tmp2_v4.i.i to i32*
  store i32 134517330, i32* %5, align 4
  %6 = tail call fastcc { i32, i32 } @Func_initializeArray(i32 %tmp2_v4.i.i, i32 %tmp2_v.i2.i)
  %7 = extractvalue { i32, i32 } %6, 0
  %8 = extractvalue { i32, i32 } %6, 1
  %tmp2_v.i.i = add i32 %8, -44
  %9 = inttoptr i32 %7 to i32*
  store i32 %tmp2_v.i.i, i32* %9, align 4
  %tmp2_v1.i.i = add i32 %7, 4
  %10 = inttoptr i32 %tmp2_v1.i.i to i32*
  store i32 0, i32* %10, align 4
  %tmp2_v2.i.i = add i32 %7, -4
  %11 = inttoptr i32 %tmp2_v2.i.i to i32*
  store i32 134517351, i32* %11, align 4
  %12 = tail call fastcc i32 @Func_printArray(i32 %tmp2_v2.i.i, i32 %8)
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn writeonly "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #2 = { naked noinline "frame-pointer"="none" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nosync nounwind willreturn }
attributes #5 = { norecurse nounwind uwtable "frame-pointer"="none" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nosync nounwind readnone willreturn }
attributes #7 = { nofree nosync nounwind }
attributes #8 = { nounwind }
attributes #9 = { norecurse nounwind }
attributes #10 = { nounwind readnone }
attributes #11 = { nobuiltin nounwind "no-builtins" }

!llvm.ident = !{!0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"clang version 14.0.0"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{i32 1, !"NumRegisterParameters", i32 0}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C++ TBAA"}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !8, i64 0}
!12 = !{i32 0, i32 1}
!13 = !{i32 0, i32 0}
!14 = !{!"printf"}
