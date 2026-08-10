.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


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
        "Lkotlin/jvm/functions/Function2<",
        "Landroidx/compose/runtime/Composer;",
        "Ljava/lang/Integer;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $$changed:I

.field final synthetic $height:F

.field final synthetic $horizontalPadding:F

.field final synthetic $isPhone:Z

.field final synthetic $isPortrait:Z

.field final synthetic $tmp0_rcvr:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

.field final synthetic $verticalPadding:F


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;FFFZZI)V
    .locals 0

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$tmp0_rcvr:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$height:F

    iput p3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$horizontalPadding:F

    iput p4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$verticalPadding:F

    iput-boolean p5, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$isPhone:Z

    iput-boolean p6, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$isPortrait:Z

    iput p7, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$$changed:I

    const/4 p1, 0x2

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroidx/compose/runtime/Composer;

    check-cast p2, Ljava/lang/Number;

    invoke-virtual {p2}, Ljava/lang/Number;->intValue()I

    move-result p2

    invoke-virtual {p0, p1, p2}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->invoke(Landroidx/compose/runtime/Composer;I)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Landroidx/compose/runtime/Composer;I)V
    .locals 8

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$tmp0_rcvr:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iget v1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$height:F

    iget v2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$horizontalPadding:F

    iget v3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$verticalPadding:F

    iget-boolean v4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$isPhone:Z

    iget-boolean v5, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$isPortrait:Z

    iget p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenAim$2;->$$changed:I

    or-int/lit8 v7, p2, 0x1

    move-object v6, p1

    invoke-virtual/range {v0 .. v7}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanScreenAim-jTDHpeQ(FFFZZLandroidx/compose/runtime/Composer;I)V

    return-void
.end method
