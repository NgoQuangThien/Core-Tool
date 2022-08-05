; ModuleID = 'xdp_pass_kern.c'
source_filename = "xdp_pass_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.hdr_cursor = type { i8* }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.collect_vlans = type { [2 x i16] }
%struct.vlan_hdr = type { i16, i16 }

@xdp_prog_simple.____fmt = private unnamed_addr constant [21 x i8] c"mac: %llu, ip: %llu\0A\00", align 1
@_license = global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@llvm.used = appending global [2 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_prog_simple to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define i32 @xdp_prog_simple(%struct.xdp_md* nocapture readonly) #0 section "xdp" !dbg !39 {
  %2 = alloca [21 x i8], align 1
  tail call void @llvm.dbg.value(metadata %struct.xdp_md* %0, i64 0, metadata !51, metadata !105), !dbg !106
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !107
  %4 = load i32, i32* %3, align 4, !dbg !107, !tbaa !108
  %5 = zext i32 %4 to i64, !dbg !113
  %6 = inttoptr i64 %5 to i8*, !dbg !114
  tail call void @llvm.dbg.value(metadata i8* %6, i64 0, metadata !52, metadata !105), !dbg !115
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !116
  %8 = load i32, i32* %7, align 4, !dbg !116, !tbaa !117
  %9 = zext i32 %8 to i64, !dbg !118
  %10 = inttoptr i64 %9 to i8*, !dbg !119
  tail call void @llvm.dbg.value(metadata i8* %10, i64 0, metadata !53, metadata !105), !dbg !120
  tail call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, i64 0, metadata !54, metadata !105), !dbg !121
  tail call void @llvm.dbg.value(metadata %struct.ethhdr** undef, i64 0, metadata !59, metadata !105), !dbg !122
  tail call void @llvm.dbg.value(metadata %struct.collect_vlans* undef, i64 0, metadata !73, metadata !105), !dbg !123
  tail call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, i64 0, metadata !124, metadata !105) #3, !dbg !135
  tail call void @llvm.dbg.value(metadata i8* %10, i64 0, metadata !132, metadata !105) #3, !dbg !137
  tail call void @llvm.dbg.value(metadata %struct.ethhdr** undef, i64 0, metadata !133, metadata !105) #3, !dbg !138
  tail call void @llvm.dbg.value(metadata %struct.collect_vlans* undef, i64 0, metadata !134, metadata !105) #3, !dbg !139
  tail call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, i64 0, metadata !140, metadata !105) #3, !dbg !156
  tail call void @llvm.dbg.value(metadata i8* %10, i64 0, metadata !143, metadata !105) #3, !dbg !158
  tail call void @llvm.dbg.value(metadata %struct.ethhdr** undef, i64 0, metadata !144, metadata !105) #3, !dbg !159
  tail call void @llvm.dbg.value(metadata %struct.collect_vlans* undef, i64 0, metadata !145, metadata !105) #3, !dbg !160
  tail call void @llvm.dbg.value(metadata i8* %6, i64 0, metadata !146, metadata !105) #3, !dbg !161
  tail call void @llvm.dbg.value(metadata i32 14, i64 0, metadata !147, metadata !105) #3, !dbg !162
  %11 = getelementptr i8, i8* %6, i64 14, !dbg !163
  %12 = icmp ugt i8* %11, %10, !dbg !165
  br i1 %12, label %95, label %13, !dbg !166

; <label>:13:                                     ; preds = %1
  tail call void @llvm.dbg.value(metadata i8* %11, i64 0, metadata !148, metadata !105) #3, !dbg !167
  %14 = getelementptr inbounds i8, i8* %6, i64 12, !dbg !168
  %15 = bitcast i8* %14 to i16*, !dbg !168
  %16 = load i16, i16* %15, align 1, !dbg !168, !tbaa !169
  tail call void @llvm.dbg.value(metadata i16 %16, i64 0, metadata !154, metadata !105) #3, !dbg !172
  tail call void @llvm.dbg.value(metadata i32 0, i64 0, metadata !155, metadata !105) #3, !dbg !173
  tail call void @llvm.dbg.value(metadata i32 0, i64 0, metadata !155, metadata !105) #3, !dbg !173
  tail call void @llvm.dbg.value(metadata i16 %16, i64 0, metadata !154, metadata !105) #3, !dbg !172
  tail call void @llvm.dbg.value(metadata i8* %11, i64 0, metadata !148, metadata !105) #3, !dbg !167
  %17 = inttoptr i64 %9 to %struct.vlan_hdr*
  tail call void @llvm.dbg.value(metadata i8* %11, i64 0, metadata !148, metadata !105) #3, !dbg !167
  tail call void @llvm.dbg.value(metadata i16 %16, i64 0, metadata !154, metadata !105) #3, !dbg !172
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !155, metadata !105) #3, !dbg !173
  switch i16 %16, label %34 [
    i16 -22392, label %18
    i16 129, label %18
  ], !dbg !174

; <label>:18:                                     ; preds = %13, %13
  %19 = getelementptr inbounds i8, i8* %6, i64 18, !dbg !178
  %20 = bitcast i8* %19 to %struct.vlan_hdr*, !dbg !178
  %21 = icmp ugt %struct.vlan_hdr* %20, %17, !dbg !180
  br i1 %21, label %95, label %22, !dbg !181

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds i8, i8* %6, i64 16, !dbg !182
  %24 = bitcast i8* %23 to i16*, !dbg !182
  %25 = load i16, i16* %24, align 2, !dbg !182, !tbaa !183
  tail call void @llvm.dbg.value(metadata i16 %25, i64 0, metadata !154, metadata !105) #3, !dbg !172
  tail call void @llvm.dbg.value(metadata %struct.vlan_hdr* %20, i64 0, metadata !148, metadata !105) #3, !dbg !167
  tail call void @llvm.dbg.value(metadata i16 %25, i64 0, metadata !154, metadata !105) #3, !dbg !172
  tail call void @llvm.dbg.value(metadata %struct.vlan_hdr* %20, i64 0, metadata !148, metadata !105) #3, !dbg !167
  tail call void @llvm.dbg.value(metadata i8* %11, i64 0, metadata !148, metadata !105) #3, !dbg !167
  tail call void @llvm.dbg.value(metadata i16 %16, i64 0, metadata !154, metadata !105) #3, !dbg !172
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !155, metadata !105) #3, !dbg !173
  switch i16 %25, label %34 [
    i16 -22392, label %26
    i16 129, label %26
  ], !dbg !174

; <label>:26:                                     ; preds = %22, %22
  %27 = getelementptr inbounds i8, i8* %6, i64 22, !dbg !178
  %28 = bitcast i8* %27 to %struct.vlan_hdr*, !dbg !178
  %29 = icmp ugt %struct.vlan_hdr* %28, %17, !dbg !180
  br i1 %29, label %95, label %30, !dbg !181

; <label>:30:                                     ; preds = %26
  %31 = getelementptr inbounds i8, i8* %6, i64 20, !dbg !182
  %32 = bitcast i8* %31 to i16*, !dbg !182
  %33 = load i16, i16* %32, align 2, !dbg !182, !tbaa !183
  tail call void @llvm.dbg.value(metadata i16 %25, i64 0, metadata !154, metadata !105) #3, !dbg !172
  br label %34, !dbg !185

; <label>:34:                                     ; preds = %13, %22, %30
  %35 = phi i8* [ %11, %13 ], [ %19, %22 ], [ %27, %30 ]
  %36 = phi i16 [ %16, %13 ], [ %25, %22 ], [ %33, %30 ]
  %37 = icmp ne i16 %36, 1544, !dbg !187
  %38 = getelementptr i8, i8* %35, i64 28, !dbg !188
  %39 = icmp ugt i8* %38, %10, !dbg !201
  %40 = or i1 %37, %39, !dbg !202
  tail call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, i64 0, metadata !54, metadata !105), !dbg !121
  tail call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, i64 0, metadata !195, metadata !105), !dbg !203
  tail call void @llvm.dbg.value(metadata i8* %10, i64 0, metadata !196, metadata !105), !dbg !204
  tail call void @llvm.dbg.value(metadata i8* %35, i64 0, metadata !198, metadata !105), !dbg !205
  tail call void @llvm.dbg.value(metadata i32 28, i64 0, metadata !199, metadata !105), !dbg !206
  br i1 %40, label %95, label %41, !dbg !202

; <label>:41:                                     ; preds = %34
  %42 = getelementptr inbounds i8, i8* %35, i64 6, !dbg !207
  %43 = bitcast i8* %42 to i16*, !dbg !207
  %44 = load i16, i16* %43, align 2, !dbg !207, !tbaa !208
  %45 = icmp eq i16 %44, 512, !dbg !210
  br i1 %45, label %46, label %95, !dbg !211

; <label>:46:                                     ; preds = %41
  %47 = getelementptr inbounds [21 x i8], [21 x i8]* %2, i64 0, i64 0, !dbg !212
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %47) #3, !dbg !212
  tail call void @llvm.dbg.declare(metadata [21 x i8]* %2, metadata !96, metadata !105), !dbg !212
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %47, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @xdp_prog_simple.____fmt, i64 0, i64 0), i64 21, i32 1, i1 false), !dbg !212
  tail call void @llvm.dbg.value(metadata i8* %35, i64 0, metadata !81, metadata !105), !dbg !213
  %48 = getelementptr inbounds i8, i8* %35, i64 8, !dbg !212
  tail call void @llvm.dbg.value(metadata i8* %48, i64 0, metadata !214, metadata !105), !dbg !226
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 5, i64 0, metadata !225, metadata !105), !dbg !229
  tail call void @llvm.dbg.value(metadata i32 5, i64 0, metadata !225, metadata !105), !dbg !229
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !225, metadata !105), !dbg !229
  %49 = getelementptr inbounds i8, i8* %35, i64 13, !dbg !230
  %50 = load i8, i8* %49, align 1, !dbg !230, !tbaa !233
  %51 = zext i8 %50 to i64, !dbg !230
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !225, metadata !105), !dbg !229
  %52 = shl nuw nsw i64 %51, 8, !dbg !234
  %53 = getelementptr inbounds i8, i8* %35, i64 12, !dbg !230
  %54 = load i8, i8* %53, align 1, !dbg !230, !tbaa !233
  %55 = zext i8 %54 to i64, !dbg !230
  %56 = or i64 %52, %55, !dbg !235
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !225, metadata !105), !dbg !229
  %57 = shl nuw nsw i64 %56, 8, !dbg !234
  %58 = getelementptr inbounds i8, i8* %35, i64 11, !dbg !230
  %59 = load i8, i8* %58, align 1, !dbg !230, !tbaa !233
  %60 = zext i8 %59 to i64, !dbg !230
  %61 = or i64 %57, %60, !dbg !235
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !225, metadata !105), !dbg !229
  %62 = shl nuw nsw i64 %61, 8, !dbg !234
  %63 = getelementptr inbounds i8, i8* %35, i64 10, !dbg !230
  %64 = load i8, i8* %63, align 1, !dbg !230, !tbaa !233
  %65 = zext i8 %64 to i64, !dbg !230
  %66 = or i64 %62, %65, !dbg !235
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !225, metadata !105), !dbg !229
  %67 = shl i64 %66, 8, !dbg !234
  %68 = getelementptr inbounds i8, i8* %35, i64 9, !dbg !230
  %69 = load i8, i8* %68, align 1, !dbg !230, !tbaa !233
  %70 = zext i8 %69 to i64, !dbg !230
  %71 = or i64 %67, %70, !dbg !235
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !225, metadata !105), !dbg !229
  %72 = shl i64 %71, 8, !dbg !234
  %73 = load i8, i8* %48, align 1, !dbg !230, !tbaa !233
  %74 = zext i8 %73 to i64, !dbg !230
  %75 = or i64 %72, %74, !dbg !235
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i64 %51, i64 0, metadata !224, metadata !105), !dbg !228
  tail call void @llvm.dbg.value(metadata i8* %35, i64 0, metadata !81, metadata !105), !dbg !213
  %76 = getelementptr inbounds i8, i8* %35, i64 14, !dbg !212
  tail call void @llvm.dbg.value(metadata i8* %76, i64 0, metadata !236, metadata !105), !dbg !241
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i32 3, i64 0, metadata !240, metadata !105), !dbg !244
  tail call void @llvm.dbg.value(metadata i32 3, i64 0, metadata !240, metadata !105), !dbg !244
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !240, metadata !105), !dbg !244
  %77 = getelementptr inbounds i8, i8* %35, i64 17, !dbg !245
  %78 = load i8, i8* %77, align 1, !dbg !245, !tbaa !233
  %79 = zext i8 %78 to i64, !dbg !245
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !240, metadata !105), !dbg !244
  %80 = shl nuw nsw i64 %79, 8, !dbg !248
  %81 = getelementptr inbounds i8, i8* %35, i64 16, !dbg !245
  %82 = load i8, i8* %81, align 1, !dbg !245, !tbaa !233
  %83 = zext i8 %82 to i64, !dbg !245
  %84 = or i64 %80, %83, !dbg !249
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !240, metadata !105), !dbg !244
  %85 = shl nuw nsw i64 %84, 8, !dbg !248
  %86 = getelementptr inbounds i8, i8* %35, i64 15, !dbg !245
  %87 = load i8, i8* %86, align 1, !dbg !245, !tbaa !233
  %88 = zext i8 %87 to i64, !dbg !245
  %89 = or i64 %85, %88, !dbg !249
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 0, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i32 undef, i64 0, metadata !240, metadata !105), !dbg !244
  %90 = shl nuw nsw i64 %89, 8, !dbg !248
  %91 = load i8, i8* %76, align 1, !dbg !245, !tbaa !233
  %92 = zext i8 %91 to i64, !dbg !245
  %93 = or i64 %90, %92, !dbg !249
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  tail call void @llvm.dbg.value(metadata i64 %79, i64 0, metadata !239, metadata !105), !dbg !243
  %94 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %47, i32 21, i64 %75, i64 %93) #3, !dbg !212
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %47) #3, !dbg !250
  br label %95, !dbg !251

; <label>:95:                                     ; preds = %26, %18, %34, %1, %41, %46
  ret i32 2, !dbg !252
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!35, !36, !37}
!llvm.ident = !{!38}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 82, type: !32, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !13, globals: !19)
!3 = !DIFile(filename: "xdp_pass_kern.c", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, size: 32, elements: !7)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!7 = !{!8, !9, !10, !11, !12}
!8 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!9 = !DIEnumerator(name: "XDP_DROP", value: 1)
!10 = !DIEnumerator(name: "XDP_PASS", value: 2)
!11 = !DIEnumerator(name: "XDP_TX", value: 3)
!12 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!13 = !{!14, !15, !16}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!15 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !17, line: 23, baseType: !18)
!17 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!18 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!19 = !{!0, !20}
!20 = !DIGlobalVariableExpression(var: !21)
!21 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !22, line: 152, type: !23, isLocal: true, isDefinition: true)
!22 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DISubroutineType(types: !25)
!25 = !{!26, !27, !30, null}
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !29)
!29 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !17, line: 26, baseType: !31)
!31 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 32, elements: !33)
!33 = !{!34}
!34 = !DISubrange(count: 4)
!35 = !{i32 2, !"Dwarf Version", i32 4}
!36 = !{i32 2, !"Debug Info Version", i32 3}
!37 = !{i32 1, !"wchar_size", i32 4}
!38 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!39 = distinct !DISubprogram(name: "xdp_prog_simple", scope: !3, file: !3, line: 50, type: !40, isLocal: false, isDefinition: true, scopeLine: 51, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !50)
!40 = !DISubroutineType(types: !41)
!41 = !{!26, !42}
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !44)
!44 = !{!45, !46, !47, !48, !49}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !43, file: !6, line: 2857, baseType: !30, size: 32)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !43, file: !6, line: 2858, baseType: !30, size: 32, offset: 32)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !43, file: !6, line: 2859, baseType: !30, size: 32, offset: 64)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !43, file: !6, line: 2861, baseType: !30, size: 32, offset: 96)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !43, file: !6, line: 2862, baseType: !30, size: 32, offset: 128)
!50 = !{!51, !52, !53, !54, !59, !73, !80, !81, !95, !96}
!51 = !DILocalVariable(name: "ctx", arg: 1, scope: !39, file: !3, line: 50, type: !42)
!52 = !DILocalVariable(name: "data", scope: !39, file: !3, line: 52, type: !14)
!53 = !DILocalVariable(name: "data_end", scope: !39, file: !3, line: 53, type: !14)
!54 = !DILocalVariable(name: "nh", scope: !39, file: !3, line: 55, type: !55)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !56, line: 36, size: 64, elements: !57)
!56 = !DIFile(filename: "./parsing_helpers.h", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!57 = !{!58}
!58 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !55, file: !56, line: 37, baseType: !14, size: 64)
!59 = !DILocalVariable(name: "eth", scope: !39, file: !3, line: 58, type: !60)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!61 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !62, line: 145, size: 112, elements: !63)
!62 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!63 = !{!64, !69, !70}
!64 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !61, file: !62, line: 146, baseType: !65, size: 48)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !66, size: 48, elements: !67)
!66 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!67 = !{!68}
!68 = !DISubrange(count: 6)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !61, file: !62, line: 147, baseType: !65, size: 48, offset: 48)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !61, file: !62, line: 148, baseType: !71, size: 16, offset: 96)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !72, line: 28, baseType: !16)
!72 = !DIFile(filename: "/usr/include/linux/types.h", directory: "/home/soc/Detect-New-Device/kernel_program/main")
!73 = !DILocalVariable(name: "vlans", scope: !39, file: !3, line: 59, type: !74)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !56, line: 57, size: 32, elements: !75)
!75 = !{!76}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !74, file: !56, line: 58, baseType: !77, size: 32)
!77 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 32, elements: !78)
!78 = !{!79}
!79 = !DISubrange(count: 2)
!80 = !DILocalVariable(name: "eth_type", scope: !39, file: !3, line: 60, type: !26)
!81 = !DILocalVariable(name: "arphdr", scope: !39, file: !3, line: 62, type: !82)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "arphdr", file: !56, line: 61, size: 224, elements: !84)
!84 = !{!85, !86, !87, !88, !89, !90, !91, !93, !94}
!85 = !DIDerivedType(tag: DW_TAG_member, name: "ar_hrd", scope: !83, file: !56, line: 62, baseType: !71, size: 16)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "ar_pro", scope: !83, file: !56, line: 63, baseType: !71, size: 16, offset: 16)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "ar_hln", scope: !83, file: !56, line: 64, baseType: !66, size: 8, offset: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "ar_pln", scope: !83, file: !56, line: 65, baseType: !66, size: 8, offset: 40)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "ar_op", scope: !83, file: !56, line: 66, baseType: !71, size: 16, offset: 48)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "ar_sha", scope: !83, file: !56, line: 67, baseType: !65, size: 48, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "ar_sip", scope: !83, file: !56, line: 68, baseType: !92, size: 32, offset: 112)
!92 = !DICompositeType(tag: DW_TAG_array_type, baseType: !66, size: 32, elements: !33)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "ar_tha", scope: !83, file: !56, line: 69, baseType: !65, size: 48, offset: 144)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "ar_tip", scope: !83, file: !56, line: 70, baseType: !92, size: 32, offset: 192)
!95 = !DILocalVariable(name: "arp_type", scope: !39, file: !3, line: 63, type: !26)
!96 = !DILocalVariable(name: "____fmt", scope: !97, file: !3, line: 72, type: !102)
!97 = distinct !DILexicalBlock(scope: !98, file: !3, line: 72, column: 4)
!98 = distinct !DILexicalBlock(scope: !99, file: !3, line: 70, column: 3)
!99 = distinct !DILexicalBlock(scope: !100, file: !3, line: 69, column: 7)
!100 = distinct !DILexicalBlock(scope: !101, file: !3, line: 67, column: 2)
!101 = distinct !DILexicalBlock(scope: !39, file: !3, line: 66, column: 6)
!102 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 168, elements: !103)
!103 = !{!104}
!104 = !DISubrange(count: 21)
!105 = !DIExpression()
!106 = !DILocation(line: 50, column: 37, scope: !39)
!107 = !DILocation(line: 52, column: 34, scope: !39)
!108 = !{!109, !110, i64 0}
!109 = !{!"xdp_md", !110, i64 0, !110, i64 4, !110, i64 8, !110, i64 12, !110, i64 16}
!110 = !{!"int", !111, i64 0}
!111 = !{!"omnipotent char", !112, i64 0}
!112 = !{!"Simple C/C++ TBAA"}
!113 = !DILocation(line: 52, column: 23, scope: !39)
!114 = !DILocation(line: 52, column: 15, scope: !39)
!115 = !DILocation(line: 52, column: 8, scope: !39)
!116 = !DILocation(line: 53, column: 38, scope: !39)
!117 = !{!109, !110, i64 4}
!118 = !DILocation(line: 53, column: 27, scope: !39)
!119 = !DILocation(line: 53, column: 19, scope: !39)
!120 = !DILocation(line: 53, column: 8, scope: !39)
!121 = !DILocation(line: 55, column: 20, scope: !39)
!122 = !DILocation(line: 58, column: 17, scope: !39)
!123 = !DILocation(line: 59, column: 23, scope: !39)
!124 = !DILocalVariable(name: "nh", arg: 1, scope: !125, file: !56, line: 129, type: !128)
!125 = distinct !DISubprogram(name: "parse_ethhdr", scope: !56, file: !56, line: 129, type: !126, isLocal: true, isDefinition: true, scopeLine: 133, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !131)
!126 = !DISubroutineType(types: !127)
!127 = !{!26, !128, !14, !129, !130}
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!129 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!130 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !74, size: 64)
!131 = !{!124, !132, !133, !134}
!132 = !DILocalVariable(name: "data_end", arg: 2, scope: !125, file: !56, line: 130, type: !14)
!133 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !125, file: !56, line: 131, type: !129)
!134 = !DILocalVariable(name: "vlans", arg: 4, scope: !125, file: !56, line: 132, type: !130)
!135 = !DILocation(line: 129, column: 60, scope: !125, inlinedAt: !136)
!136 = distinct !DILocation(line: 65, column: 13, scope: !39)
!137 = !DILocation(line: 130, column: 12, scope: !125, inlinedAt: !136)
!138 = !DILocation(line: 131, column: 22, scope: !125, inlinedAt: !136)
!139 = !DILocation(line: 132, column: 28, scope: !125, inlinedAt: !136)
!140 = !DILocalVariable(name: "nh", arg: 1, scope: !141, file: !56, line: 84, type: !128)
!141 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !56, file: !56, line: 84, type: !126, isLocal: true, isDefinition: true, scopeLine: 88, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !142)
!142 = !{!140, !143, !144, !145, !146, !147, !148, !154, !155}
!143 = !DILocalVariable(name: "data_end", arg: 2, scope: !141, file: !56, line: 85, type: !14)
!144 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !141, file: !56, line: 86, type: !129)
!145 = !DILocalVariable(name: "vlans", arg: 4, scope: !141, file: !56, line: 87, type: !130)
!146 = !DILocalVariable(name: "eth", scope: !141, file: !56, line: 89, type: !60)
!147 = !DILocalVariable(name: "hdrsize", scope: !141, file: !56, line: 90, type: !26)
!148 = !DILocalVariable(name: "vlh", scope: !141, file: !56, line: 91, type: !149)
!149 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !150, size: 64)
!150 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !56, line: 45, size: 32, elements: !151)
!151 = !{!152, !153}
!152 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !150, file: !56, line: 46, baseType: !71, size: 16)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !150, file: !56, line: 47, baseType: !71, size: 16, offset: 16)
!154 = !DILocalVariable(name: "h_proto", scope: !141, file: !56, line: 92, type: !16)
!155 = !DILocalVariable(name: "i", scope: !141, file: !56, line: 93, type: !26)
!156 = !DILocation(line: 84, column: 65, scope: !141, inlinedAt: !157)
!157 = distinct !DILocation(line: 134, column: 9, scope: !125, inlinedAt: !136)
!158 = !DILocation(line: 85, column: 17, scope: !141, inlinedAt: !157)
!159 = !DILocation(line: 86, column: 27, scope: !141, inlinedAt: !157)
!160 = !DILocation(line: 87, column: 33, scope: !141, inlinedAt: !157)
!161 = !DILocation(line: 89, column: 17, scope: !141, inlinedAt: !157)
!162 = !DILocation(line: 90, column: 6, scope: !141, inlinedAt: !157)
!163 = !DILocation(line: 98, column: 14, scope: !164, inlinedAt: !157)
!164 = distinct !DILexicalBlock(scope: !141, file: !56, line: 98, column: 6)
!165 = !DILocation(line: 98, column: 24, scope: !164, inlinedAt: !157)
!166 = !DILocation(line: 98, column: 6, scope: !141, inlinedAt: !157)
!167 = !DILocation(line: 91, column: 19, scope: !141, inlinedAt: !157)
!168 = !DILocation(line: 104, column: 17, scope: !141, inlinedAt: !157)
!169 = !{!170, !171, i64 12}
!170 = !{!"ethhdr", !111, i64 0, !111, i64 6, !171, i64 12}
!171 = !{!"short", !111, i64 0}
!172 = !DILocation(line: 92, column: 8, scope: !141, inlinedAt: !157)
!173 = !DILocation(line: 93, column: 6, scope: !141, inlinedAt: !157)
!174 = !DILocation(line: 111, column: 7, scope: !175, inlinedAt: !157)
!175 = distinct !DILexicalBlock(scope: !176, file: !56, line: 110, column: 39)
!176 = distinct !DILexicalBlock(scope: !177, file: !56, line: 110, column: 2)
!177 = distinct !DILexicalBlock(scope: !141, file: !56, line: 110, column: 2)
!178 = !DILocation(line: 114, column: 11, scope: !179, inlinedAt: !157)
!179 = distinct !DILexicalBlock(scope: !175, file: !56, line: 114, column: 7)
!180 = !DILocation(line: 114, column: 15, scope: !179, inlinedAt: !157)
!181 = !DILocation(line: 114, column: 7, scope: !175, inlinedAt: !157)
!182 = !DILocation(line: 117, column: 18, scope: !175, inlinedAt: !157)
!183 = !{!184, !171, i64 2}
!184 = !{!"vlan_hdr", !171, i64 0, !171, i64 2}
!185 = !DILocation(line: 119, column: 4, scope: !186, inlinedAt: !157)
!186 = distinct !DILexicalBlock(scope: !175, file: !56, line: 118, column: 7)
!187 = !DILocation(line: 66, column: 15, scope: !101)
!188 = !DILocation(line: 143, column: 11, scope: !189, inlinedAt: !200)
!189 = distinct !DILexicalBlock(scope: !190, file: !56, line: 143, column: 6)
!190 = distinct !DISubprogram(name: "parse_arphdr", scope: !56, file: !56, line: 137, type: !191, isLocal: true, isDefinition: true, scopeLine: 140, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !194)
!191 = !DISubroutineType(types: !192)
!192 = !{!26, !128, !14, !193}
!193 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!194 = !{!195, !196, !197, !198, !199}
!195 = !DILocalVariable(name: "nh", arg: 1, scope: !190, file: !56, line: 137, type: !128)
!196 = !DILocalVariable(name: "data_end", arg: 2, scope: !190, file: !56, line: 138, type: !14)
!197 = !DILocalVariable(name: "arphdr", arg: 3, scope: !190, file: !56, line: 139, type: !193)
!198 = !DILocalVariable(name: "arph", scope: !190, file: !56, line: 141, type: !82)
!199 = !DILocalVariable(name: "hdrsize", scope: !190, file: !56, line: 142, type: !26)
!200 = distinct !DILocation(line: 68, column: 14, scope: !100)
!201 = !DILocation(line: 143, column: 15, scope: !189, inlinedAt: !200)
!202 = !DILocation(line: 66, column: 6, scope: !39)
!203 = !DILocation(line: 137, column: 60, scope: !190, inlinedAt: !200)
!204 = !DILocation(line: 138, column: 12, scope: !190, inlinedAt: !200)
!205 = !DILocation(line: 141, column: 17, scope: !190, inlinedAt: !200)
!206 = !DILocation(line: 142, column: 6, scope: !190, inlinedAt: !200)
!207 = !DILocation(line: 152, column: 15, scope: !190, inlinedAt: !200)
!208 = !{!209, !171, i64 6}
!209 = !{!"arphdr", !171, i64 0, !171, i64 2, !111, i64 4, !111, i64 5, !171, i64 6, !111, i64 8, !111, i64 14, !111, i64 18, !111, i64 24}
!210 = !DILocation(line: 69, column: 16, scope: !99)
!211 = !DILocation(line: 69, column: 7, scope: !100)
!212 = !DILocation(line: 72, column: 4, scope: !97)
!213 = !DILocation(line: 62, column: 17, scope: !39)
!214 = !DILocalVariable(name: "addr", arg: 1, scope: !215, file: !3, line: 29, type: !220)
!215 = distinct !DISubprogram(name: "mac_addr_to_u64", scope: !3, file: !3, line: 29, type: !216, isLocal: true, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !223)
!216 = !DISubroutineType(types: !217)
!217 = !{!218, !220}
!218 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !17, line: 30, baseType: !219)
!219 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!220 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !221, size: 64)
!221 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !222)
!222 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !17, line: 20, baseType: !66)
!223 = !{!214, !224, !225}
!224 = !DILocalVariable(name: "u", scope: !215, file: !3, line: 31, type: !218)
!225 = !DILocalVariable(name: "i", scope: !215, file: !3, line: 32, type: !26)
!226 = !DILocation(line: 29, column: 49, scope: !215, inlinedAt: !227)
!227 = distinct !DILocation(line: 72, column: 4, scope: !97)
!228 = !DILocation(line: 31, column: 8, scope: !215, inlinedAt: !227)
!229 = !DILocation(line: 32, column: 6, scope: !215, inlinedAt: !227)
!230 = !DILocation(line: 35, column: 16, scope: !231, inlinedAt: !227)
!231 = distinct !DILexicalBlock(scope: !232, file: !3, line: 34, column: 2)
!232 = distinct !DILexicalBlock(scope: !215, file: !3, line: 34, column: 2)
!233 = !{!111, !111, i64 0}
!234 = !DILocation(line: 35, column: 9, scope: !231, inlinedAt: !227)
!235 = !DILocation(line: 35, column: 14, scope: !231, inlinedAt: !227)
!236 = !DILocalVariable(name: "addr", arg: 1, scope: !237, file: !3, line: 39, type: !220)
!237 = distinct !DISubprogram(name: "ip_addr_to_64", scope: !3, file: !3, line: 39, type: !216, isLocal: true, isDefinition: true, scopeLine: 40, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !238)
!238 = !{!236, !239, !240}
!239 = !DILocalVariable(name: "u", scope: !237, file: !3, line: 41, type: !218)
!240 = !DILocalVariable(name: "i", scope: !237, file: !3, line: 42, type: !26)
!241 = !DILocation(line: 39, column: 47, scope: !237, inlinedAt: !242)
!242 = distinct !DILocation(line: 72, column: 4, scope: !97)
!243 = !DILocation(line: 41, column: 8, scope: !237, inlinedAt: !242)
!244 = !DILocation(line: 42, column: 6, scope: !237, inlinedAt: !242)
!245 = !DILocation(line: 45, column: 16, scope: !246, inlinedAt: !242)
!246 = distinct !DILexicalBlock(scope: !247, file: !3, line: 44, column: 2)
!247 = distinct !DILexicalBlock(scope: !237, file: !3, line: 44, column: 2)
!248 = !DILocation(line: 45, column: 9, scope: !246, inlinedAt: !242)
!249 = !DILocation(line: 45, column: 14, scope: !246, inlinedAt: !242)
!250 = !DILocation(line: 72, column: 4, scope: !98)
!251 = !DILocation(line: 76, column: 3, scope: !98)
!252 = !DILocation(line: 79, column: 2, scope: !39)
