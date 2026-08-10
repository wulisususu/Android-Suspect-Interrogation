.class public final Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;
.super Ljava/lang/Object;
.source "Sizes.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSizes.kt\nKotlin\n*S Kotlin\n*F\n+ 1 Sizes.kt\ncom/outsystems/plugins/barcode/view/ui/theme/SizesKt\n+ 2 Dp.kt\nandroidx/compose/ui/unit/DpKt\n*L\n1#1,21:1\n174#2:22\n174#2:23\n174#2:24\n174#2:25\n174#2:26\n174#2:27\n174#2:28\n174#2:29\n174#2:30\n*S KotlinDebug\n*F\n+ 1 Sizes.kt\ncom/outsystems/plugins/barcode/view/ui/theme/SizesKt\n*L\n5#1:22\n6#1:23\n7#1:24\n9#1:25\n10#1:26\n13#1:27\n14#1:28\n15#1:29\n20#1:30\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u000e\n\u0002\u0010\u0007\n\u0002\u0008\u0003\n\u0002\u0010\u0006\n\u0002\u0008\u0006\"\u0013\u0010\u0000\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u0002\u0010\u0003\"\u0013\u0010\u0005\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u0006\u0010\u0003\"\u0013\u0010\u0007\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u0008\u0010\u0003\"\u0013\u0010\t\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\n\u0010\u0003\"\u0013\u0010\u000b\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u000c\u0010\u0003\"\u0013\u0010\r\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u000e\u0010\u0003\"\u000e\u0010\u000f\u001a\u00020\u0010X\u0086T\u00a2\u0006\u0002\n\u0000\"\u0013\u0010\u0011\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u0012\u0010\u0003\"\u000e\u0010\u0013\u001a\u00020\u0014X\u0086T\u00a2\u0006\u0002\n\u0000\"\u000e\u0010\u0015\u001a\u00020\u0014X\u0086T\u00a2\u0006\u0002\n\u0000\"\u0013\u0010\u0016\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u0017\u0010\u0003\"\u0013\u0010\u0018\u001a\u00020\u0001\u00a2\u0006\n\n\u0002\u0010\u0004\u001a\u0004\u0008\u0019\u0010\u0003\u00a8\u0006\u001a"
    }
    d2 = {
        "ActionButtonsDistance",
        "Landroidx/compose/ui/unit/Dp;",
        "getActionButtonsDistance",
        "()F",
        "F",
        "NoPadding",
        "getNoPadding",
        "ScanButtonCornerRadius",
        "getScanButtonCornerRadius",
        "ScanButtonStrokeWidth",
        "getScanButtonStrokeWidth",
        "ScannerAimCornerLength",
        "getScannerAimCornerLength",
        "ScannerAimRectCornerPadding",
        "getScannerAimRectCornerPadding",
        "ScannerAimStrokeWidth",
        "",
        "ScannerBorderPadding",
        "getScannerBorderPadding",
        "SizeRatioHeight",
        "",
        "SizeRatioWidth",
        "TextToRectPadding",
        "getTextToRectPadding",
        "ZoomButtonSize",
        "getZoomButtonSize",
        "OSBarcodeLib_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final ActionButtonsDistance:F

.field private static final NoPadding:F

.field private static final ScanButtonCornerRadius:F

.field private static final ScanButtonStrokeWidth:F

.field private static final ScannerAimCornerLength:F

.field private static final ScannerAimRectCornerPadding:F

.field public static final ScannerAimStrokeWidth:F = 3.0f

.field private static final ScannerBorderPadding:F

.field public static final SizeRatioHeight:D = 0.5

.field public static final SizeRatioWidth:D = 0.6

.field private static final TextToRectPadding:F

.field private static final ZoomButtonSize:F


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    .line 22
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->NoPadding:F

    const/high16 v0, 0x42000000    # 32.0f

    .line 23
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScannerBorderPadding:F

    const/high16 v0, 0x41c00000    # 24.0f

    .line 24
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->TextToRectPadding:F

    const/high16 v0, 0x41800000    # 16.0f

    .line 25
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScannerAimRectCornerPadding:F

    const/high16 v0, 0x42480000    # 50.0f

    .line 26
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScannerAimCornerLength:F

    const/high16 v0, 0x40800000    # 4.0f

    .line 27
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScanButtonCornerRadius:F

    const/high16 v0, 0x3f800000    # 1.0f

    .line 28
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScanButtonStrokeWidth:F

    const/high16 v0, 0x42400000    # 48.0f

    .line 29
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ActionButtonsDistance:F

    const/high16 v0, 0x420c0000    # 35.0f

    .line 30
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v0

    sput v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ZoomButtonSize:F

    return-void
.end method

.method public static final getActionButtonsDistance()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ActionButtonsDistance:F

    return v0
.end method

.method public static final getNoPadding()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->NoPadding:F

    return v0
.end method

.method public static final getScanButtonCornerRadius()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScanButtonCornerRadius:F

    return v0
.end method

.method public static final getScanButtonStrokeWidth()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScanButtonStrokeWidth:F

    return v0
.end method

.method public static final getScannerAimCornerLength()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScannerAimCornerLength:F

    return v0
.end method

.method public static final getScannerAimRectCornerPadding()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScannerAimRectCornerPadding:F

    return v0
.end method

.method public static final getScannerBorderPadding()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ScannerBorderPadding:F

    return v0
.end method

.method public static final getTextToRectPadding()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->TextToRectPadding:F

    return v0
.end method

.method public static final getZoomButtonSize()F
    .locals 1

    sget v0, Lcom/outsystems/plugins/barcode/view/ui/theme/SizesKt;->ZoomButtonSize:F

    return v0
.end method
