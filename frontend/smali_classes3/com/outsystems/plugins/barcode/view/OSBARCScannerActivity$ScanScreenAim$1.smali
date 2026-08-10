.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanScreenAim-jTDHpeQ(FFFZZLandroidx/compose/runtime/Composer;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Landroidx/compose/ui/graphics/drawscope/DrawScope;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOSBARCScannerActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OSBARCScannerActivity.kt\ncom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1\n+ 2 DrawScope.kt\nandroidx/compose/ui/graphics/drawscope/DrawScopeKt\n+ 3 Dp.kt\nandroidx/compose/ui/unit/Dp\n*L\n1#1,939:1\n237#2:940\n261#2,11:941\n92#3:952\n92#3:953\n*S KotlinDebug\n*F\n+ 1 OSBARCScannerActivity.kt\ncom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1\n*L\n422#1:940\n422#1:941,11\n428#1:952\n429#1:953\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\n\u00a2\u0006\u0002\u0008\u0003"
    }
    d2 = {
        "<anonymous>",
        "",
        "Landroidx/compose/ui/graphics/drawscope/DrawScope;",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $horizontalPadding:F

.field final synthetic $isPhone:Z

.field final synthetic $isPortrait:Z

.field final synthetic $verticalPadding:F

.field final synthetic this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(ZFFZLcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)V
    .locals 0

    iput-boolean p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$isPhone:Z

    iput p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$horizontalPadding:F

    iput p3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$verticalPadding:F

    iput-boolean p4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$isPortrait:Z

    iput-object p5, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 380
    check-cast p1, Landroidx/compose/ui/graphics/drawscope/DrawScope;

    invoke-virtual {p0, p1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->invoke(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Landroidx/compose/ui/graphics/drawscope/DrawScope;)V
    .locals 26

    move-object/from16 v0, p0

    move-object/from16 v14, p1

    const-string v1, "$this$Canvas"

    invoke-static {v14, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 388
    invoke-interface/range {p1 .. p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J

    move-result-wide v1

    invoke-static {v1, v2}, Landroidx/compose/ui/geometry/Size;->getWidth-impl(J)F

    move-result v1

    .line 389
    invoke-interface/range {p1 .. p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getSize-NH-jbRc()J

    move-result-wide v2

    invoke-static {v2, v3}, Landroidx/compose/ui/geometry/Size;->getHeight-impl(J)F

    move-result v2

    iget-boolean v3, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$isPhone:Z

    const/4 v4, 0x2

    if-eqz v3, :cond_0

    iget v3, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$horizontalPadding:F

    .line 397
    invoke-interface {v14, v3}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v3

    int-to-float v5, v4

    mul-float/2addr v3, v5

    sub-float v3, v1, v3

    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v6

    invoke-interface {v14, v6}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v6

    mul-float/2addr v6, v5

    sub-float/2addr v3, v6

    iget v6, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$verticalPadding:F

    .line 398
    invoke-interface {v14, v6}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v6

    mul-float/2addr v6, v5

    sub-float v6, v2, v6

    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v7

    invoke-interface {v14, v7}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v7

    mul-float/2addr v7, v5

    sub-float/2addr v6, v7

    :goto_0
    move v15, v3

    move v13, v6

    goto :goto_1

    :cond_0
    iget-boolean v3, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$isPortrait:Z

    if-eqz v3, :cond_1

    iget v3, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$horizontalPadding:F

    .line 401
    invoke-interface {v14, v3}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v3

    int-to-float v5, v4

    mul-float/2addr v3, v5

    sub-float v3, v1, v3

    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v6

    invoke-interface {v14, v6}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v6

    mul-float/2addr v6, v5

    sub-float/2addr v3, v6

    move v13, v3

    move v15, v13

    goto :goto_1

    :cond_1
    iget v3, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$horizontalPadding:F

    .line 404
    invoke-interface {v14, v3}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v3

    int-to-float v5, v4

    mul-float/2addr v3, v5

    sub-float v3, v1, v3

    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v6

    invoke-interface {v14, v6}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v6

    mul-float/2addr v6, v5

    sub-float/2addr v3, v6

    .line 405
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v6

    invoke-interface {v14, v6}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v6

    mul-float/2addr v6, v5

    sub-float v6, v2, v6

    goto :goto_0

    :goto_1
    sub-float/2addr v1, v15

    int-to-float v12, v4

    div-float v11, v1, v12

    sub-float/2addr v2, v13

    div-float v10, v2, v12

    iget-object v1, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 412
    invoke-static {v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$getBarcodeAnalyzer$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;

    move-result-object v1

    if-nez v1, :cond_2

    const-string v1, "barcodeAnalyzer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_2
    iget-boolean v2, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->$isPortrait:Z

    invoke-virtual {v1, v2}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->setPortrait(Z)V

    .line 414
    invoke-static {}, Landroidx/compose/ui/graphics/AndroidPath_androidKt;->Path()Landroidx/compose/ui/graphics/Path;

    move-result-object v1

    .line 417
    invoke-static {v11, v10}, Landroidx/compose/ui/geometry/OffsetKt;->Offset(FF)J

    move-result-wide v2

    invoke-static {v15, v13}, Landroidx/compose/ui/geometry/SizeKt;->Size(FF)J

    move-result-wide v4

    invoke-static {v2, v3, v4, v5}, Landroidx/compose/ui/geometry/RectKt;->Rect-tz77jQw(JJ)Landroidx/compose/ui/geometry/Rect;

    move-result-object v2

    const/high16 v9, 0x41c80000    # 25.0f

    .line 418
    invoke-static {v9, v9}, Landroidx/compose/ui/geometry/CornerRadiusKt;->CornerRadius(FF)J

    move-result-wide v3

    .line 416
    invoke-static {v2, v3, v4}, Landroidx/compose/ui/geometry/RoundRectKt;->RoundRect-sniSvfs(Landroidx/compose/ui/geometry/Rect;J)Landroidx/compose/ui/geometry/RoundRect;

    move-result-object v2

    .line 415
    invoke-interface {v1, v2}, Landroidx/compose/ui/graphics/Path;->addRoundRect(Landroidx/compose/ui/geometry/RoundRect;)V

    .line 422
    sget-object v2, Landroidx/compose/ui/graphics/ClipOp;->Companion:Landroidx/compose/ui/graphics/ClipOp$Companion;

    invoke-virtual {v2}, Landroidx/compose/ui/graphics/ClipOp$Companion;->getDifference-rtfAjoo()I

    move-result v2

    .line 941
    invoke-interface/range {p1 .. p1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->getDrawContext()Landroidx/compose/ui/graphics/drawscope/DrawContext;

    move-result-object v8

    .line 945
    invoke-interface {v8}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getSize-NH-jbRc()J

    move-result-wide v6

    .line 946
    invoke-interface {v8}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v3

    invoke-interface {v3}, Landroidx/compose/ui/graphics/Canvas;->save()V

    .line 947
    invoke-interface {v8}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getTransform()Landroidx/compose/ui/graphics/drawscope/DrawTransform;

    move-result-object v3

    .line 940
    invoke-interface {v3, v1, v2}, Landroidx/compose/ui/graphics/drawscope/DrawTransform;->clipPath-mtrdD-E(Landroidx/compose/ui/graphics/Path;I)V

    .line 423
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/ColorKt;->getScannerBackgroundBlack()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    const-wide/16 v16, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    const/16 v21, 0x0

    const/16 v22, 0x7e

    const/16 v23, 0x0

    move-object/from16 v1, p1

    move-wide/from16 v24, v6

    move-wide/from16 v6, v16

    move-object/from16 v16, v8

    move/from16 v8, v18

    move/from16 v17, v9

    move-object/from16 v9, v19

    move/from16 v18, v10

    move-object/from16 v10, v20

    move/from16 v19, v11

    move/from16 v11, v21

    move/from16 v20, v12

    move/from16 v12, v22

    move/from16 v21, v13

    move-object/from16 v13, v23

    invoke-static/range {v1 .. v13}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->drawRect-n-J9OG0$default(Landroidx/compose/ui/graphics/drawscope/DrawScope;JJJFLandroidx/compose/ui/graphics/drawscope/DrawStyle;Landroidx/compose/ui/graphics/ColorFilter;IILjava/lang/Object;)V

    .line 949
    invoke-interface/range {v16 .. v16}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->getCanvas()Landroidx/compose/ui/graphics/Canvas;

    move-result-object v1

    invoke-interface {v1}, Landroidx/compose/ui/graphics/Canvas;->restore()V

    move-object/from16 v1, v16

    move-wide/from16 v2, v24

    .line 950
    invoke-interface {v1, v2, v3}, Landroidx/compose/ui/graphics/drawscope/DrawContext;->setSize-uvyYCjk(J)V

    .line 426
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v1

    invoke-interface {v14, v1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v1

    sub-float v10, v18, v1

    .line 427
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v1

    invoke-interface {v14, v1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v1

    sub-float v11, v19, v1

    add-float/2addr v15, v11

    .line 428
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v1

    mul-float v1, v1, v20

    .line 952
    invoke-static {v1}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v1

    .line 428
    invoke-interface {v14, v1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v1

    add-float/2addr v15, v1

    add-float v13, v10, v21

    .line 429
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimRectCornerPadding()F

    move-result v1

    mul-float v1, v1, v20

    .line 953
    invoke-static {v1}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v1

    .line 429
    invoke-interface {v14, v1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v1

    add-float/2addr v13, v1

    .line 430
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->getScannerAimCornerLength()F

    move-result v1

    invoke-interface {v14, v1}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->toPx-0680j_4(F)F

    move-result v1

    .line 432
    invoke-static {}, Landroidx/compose/ui/graphics/AndroidPath_androidKt;->Path()Landroidx/compose/ui/graphics/Path;

    move-result-object v9

    iget-object v2, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 436
    new-instance v4, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    add-float v12, v11, v1

    invoke-direct {v4, v12, v10}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 437
    new-instance v5, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    add-float v8, v11, v17

    invoke-direct {v5, v8, v10}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 438
    new-instance v6, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v6, v11, v10}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 439
    new-instance v7, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    add-float v3, v10, v17

    invoke-direct {v7, v11, v3}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    move/from16 v16, v8

    .line 440
    new-instance v8, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    add-float v14, v10, v1

    invoke-direct {v8, v11, v14}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    move/from16 v18, v10

    move v10, v3

    move-object v3, v9

    move/from16 v19, v10

    move/from16 v10, v16

    .line 434
    invoke-static/range {v2 .. v8}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$addCornerToAimPath(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/compose/ui/graphics/Path;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;)V

    iget-object v2, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 445
    new-instance v4, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    sub-float v8, v13, v1

    invoke-direct {v4, v11, v8}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 446
    new-instance v5, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    sub-float v7, v13, v17

    invoke-direct {v5, v11, v7}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 447
    new-instance v6, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v6, v11, v13}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 448
    new-instance v11, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v11, v10, v13}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 449
    new-instance v10, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v10, v12, v13}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    move v12, v7

    move-object v7, v11

    move v11, v8

    move-object v8, v10

    .line 443
    invoke-static/range {v2 .. v8}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$addCornerToAimPath(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/compose/ui/graphics/Path;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;)V

    iget-object v2, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 454
    new-instance v4, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    sub-float v1, v15, v1

    invoke-direct {v4, v1, v13}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 455
    new-instance v5, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    sub-float v10, v15, v17

    invoke-direct {v5, v10, v13}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 456
    new-instance v6, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v6, v15, v13}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 457
    new-instance v7, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v7, v15, v12}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 458
    new-instance v8, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v8, v15, v11}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 452
    invoke-static/range {v2 .. v8}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$addCornerToAimPath(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/compose/ui/graphics/Path;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;)V

    iget-object v2, v0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 463
    new-instance v4, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v4, v15, v14}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 464
    new-instance v5, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    move/from16 v3, v19

    invoke-direct {v5, v15, v3}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 465
    new-instance v6, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    move/from16 v3, v18

    invoke-direct {v6, v15, v3}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 466
    new-instance v7, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v7, v10, v3}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    .line 467
    new-instance v8, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;

    invoke-direct {v8, v1, v3}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;-><init>(FF)V

    move-object v3, v9

    .line 461
    invoke-static/range {v2 .. v8}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$addCornerToAimPath(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/compose/ui/graphics/Path;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$Point;)V

    .line 469
    invoke-static {}, Lcom/outsystems/plugins/barcode/view/ui/theme/ColorKt;->getScanAimWhite()J

    move-result-wide v3

    const/4 v5, 0x0

    new-instance v1, Landroidx/compose/ui/graphics/drawscope/Stroke;

    const/high16 v11, 0x40400000    # 3.0f

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x1e

    const/16 v17, 0x0

    move-object v10, v1

    invoke-direct/range {v10 .. v17}, Landroidx/compose/ui/graphics/drawscope/Stroke;-><init>(FFIILandroidx/compose/ui/graphics/PathEffect;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    move-object v6, v1

    check-cast v6, Landroidx/compose/ui/graphics/drawscope/DrawStyle;

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/16 v10, 0x34

    const/4 v11, 0x0

    move-object/from16 v1, p1

    move-object v2, v9

    move v9, v10

    move-object v10, v11

    invoke-static/range {v1 .. v10}, Landroidx/compose/ui/graphics/drawscope/DrawScope;->drawPath-LG529CI$default(Landroidx/compose/ui/graphics/drawscope/DrawScope;Landroidx/compose/ui/graphics/Path;JFLandroidx/compose/ui/graphics/drawscope/DrawStyle;Landroidx/compose/ui/graphics/ColorFilter;IILjava/lang/Object;)V

    return-void
.end method
