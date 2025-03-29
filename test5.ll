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
  %6 = tail call { i32, i32 } asm "movl    %esp, %ebx\0A\09movl    $2, %esp\0A\09calll   *$3\0A\09movl    %ebx, %esp", "={ax},={dx},r,r,{cx},{dx},~{ebx},~{dirflag},~{fpsr},~{flags}"(i32 %2, i32 %3, i32 %0, i32 %1) #9
  %7 = extractvalue { i32, i32 } %6, 0
  %8 = extractvalue { i32, i32 } %6, 1
  %9 = bitcast double* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %9) #10
  call void asm "fstpl   $0", "=*m,~{dirflag},~{fpsr},~{flags}"(double* nonnull elementtype(double) %5) #10
  %10 = load double, double* %5, align 8, !tbaa !6
  %11 = fptoui double %10 to i64
  call fastcc void @helper_fldl_ST0(i64 noundef %11) #11
  %12 = zext i32 %8 to i64
  %13 = shl nuw i64 %12, 32
  %14 = zext i32 %7 to i64
  %15 = or i64 %13, %14
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %9) #10
  ret i64 %15
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: norecurse nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %0, i8** noundef %1, i8** noundef %2) local_unnamed_addr #5 {
  %4 = tail call i32 asm "pushf\0A\09popl $0", "=r,~{dirflag},~{fpsr},~{flags}"() #9
  tail call fastcc void @helper_fninit() #11
  %5 = ptrtoint i8** %2 to i32
  store i32 %5, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194303), align 4, !tbaa !10
  %6 = ptrtoint i8** %1 to i32
  store i32 %6, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194302), align 8, !tbaa !10
  store i32 %0, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194301), align 4, !tbaa !10
  %7 = tail call i8* @llvm.returnaddress(i32 0)
  %8 = ptrtoint i8* %7 to i32
  store i32 %8, i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194300), align 16, !tbaa !10
  %9 = tail call fastcc i32 @Func_main(i32 ptrtoint (i32* getelementptr inbounds ([4194304 x i32], [4194304 x i32]* @stack, i32 0, i32 4194300) to i32)) #10
  ret i32 %9
}

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i8* @llvm.returnaddress(i32 immarg) #6

; Function Attrs: norecurse nounwind
define internal fastcc i32 @Func_main(i32 %arg_esp) unnamed_addr #7 !retregs !12 {
  %tmp2_v.i34.i = add i32 %arg_esp, -4
  %1 = inttoptr i32 %tmp2_v.i34.i to i32*
  store i32 0, i32* %1, align 4
  %tmp0_v.i36.i = add i32 %arg_esp, -76
  %tmp2_v1.i37.i = add i32 %arg_esp, -8
  %2 = inttoptr i32 %tmp2_v1.i37.i to i32*
  store i32 0, i32* %2, align 4
  %tmp2_v2.i38.i = add i32 %arg_esp, -44
  %3 = inttoptr i32 %tmp0_v.i36.i to i32*
  store i32 %tmp2_v2.i38.i, i32* %3, align 4
  %tmp2_v3.i39.i = add i32 %arg_esp, -72
  %4 = inttoptr i32 %tmp2_v3.i39.i to i32*
  store i32 134520840, i32* %4, align 4
  %tmp2_v4.i40.i = add i32 %arg_esp, -68
  %5 = inttoptr i32 %tmp2_v4.i40.i to i32*
  store i32 36, i32* %5, align 4
  %tmp2_v5.i.i = add i32 %arg_esp, -80
  %6 = inttoptr i32 %tmp2_v5.i.i to i32*
  store i32 134517178, i32* %6, align 4
  %arg.i.i = load i32, i32* %3, align 4
  %arg2.i.i = load i32, i32* %4, align 4
  %arg4.i.i = load i32, i32* %5, align 4
  %7 = inttoptr i32 %arg.i.i to i8*
  %8 = inttoptr i32 %arg2.i.i to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* align 1 %7, i8* align 1 %8, i32 %arg4.i.i, i1 false) #10
  %tmp2_v.i.i = add i32 %arg_esp, -48
  %9 = inttoptr i32 %tmp2_v.i.i to i32*
  store i32 303, i32* %9, align 4
  %tmp2_v1.i.i = add i32 %arg_esp, -52
  %10 = inttoptr i32 %tmp2_v1.i.i to i32*
  store i32 9, i32* %10, align 4
  store i32 134520876, i32* %3, align 4
  store i32 9, i32* %4, align 4
  store i32 134517213, i32* %6, align 4
  %11 = tail call x86_fastcallcc i64 @helper_stub_trampoline(i32 inreg noundef 134520876, i32 inreg noundef 0, i32 noundef %tmp0_v.i36.i, i32 noundef ptrtoint (i32 (i8*, ...)* @printf to i32)) #11, !funcname !13
  %tmp2_v.i25.i = add i32 %arg_esp, -56
  %12 = inttoptr i32 %tmp2_v.i25.i to i32*
  store i32 0, i32* %12, align 4
  %13 = load i32, i32* %10, align 4
  %.not.i.i3 = icmp sgt i32 %13, 0
  br i1 %.not.i.i3, label %BB_80491F0.i, label %.exit

BB_80491F0.i:                                     ; preds = %BB_80491F0.i, %0
  %storemerge4 = phi i32 [ %tmp0_v9.i.i, %BB_80491F0.i ], [ 0, %0 ]
  %tmp4_v.i19.i = shl i32 %storemerge4, 2
  %tmp2_v2.i20.i = add i32 %tmp4_v.i19.i, %tmp2_v2.i38.i
  %14 = inttoptr i32 %tmp2_v2.i20.i to i32*
  %15 = load i32, i32* %14, align 4
  %16 = load i32, i32* %9, align 4
  %tmp0_v5.i.i = add i32 %16, %15
  store i32 %tmp0_v5.i.i, i32* %9, align 4
  %17 = load i32, i32* %12, align 4
  %tmp0_v9.i.i = add i32 %17, 1
  store i32 %tmp0_v9.i.i, i32* %12, align 4
  %18 = load i32, i32* %10, align 4
  %.not.i.i = icmp slt i32 %tmp0_v9.i.i, %18
  br i1 %.not.i.i, label %BB_80491F0.i, label %.exit

.exit:                                            ; preds = %BB_80491F0.i, %0
  %19 = lshr i64 %11, 32
  %20 = trunc i64 %19 to i32
  %21 = load i32, i32* %9, align 4
  store i32 134520893, i32* %3, align 4
  store i32 %21, i32* %4, align 4
  store i32 134517280, i32* %6, align 4
  %22 = tail call x86_fastcallcc i64 @helper_stub_trampoline(i32 inreg noundef 134520893, i32 inreg noundef %20, i32 noundef %tmp0_v.i36.i, i32 noundef ptrtoint (i32 (i8*, ...)* @printf to i32)) #11, !funcname !13
  %23 = load i32, i32* %2, align 4
  ret i32 %23
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i32, i1 immarg) #8

attributes #0 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn writeonly "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #2 = { naked noinline "frame-pointer"="none" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nosync nounwind willreturn }
attributes #5 = { norecurse nounwind uwtable "frame-pointer"="none" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nosync nounwind readnone willreturn }
attributes #7 = { norecurse nounwind }
attributes #8 = { argmemonly nofree nounwind willreturn }
attributes #9 = { nounwind readnone }
attributes #10 = { nounwind }
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
!12 = !{i32 0, i32 0, i32 0}
!13 = !{!"printf"}
