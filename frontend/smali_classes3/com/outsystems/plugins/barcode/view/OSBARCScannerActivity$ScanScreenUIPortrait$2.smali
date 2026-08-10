.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanScreenUIPortrait-WMci_g0(Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;FFZLandroidx/compose/runtime/Composer;I)V
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

.field final synthetic $borderPadding:F

.field final synthetic $isPhone:Z

.field final synthetic $parameters:Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

.field final synthetic $screenHeight:F

.field final synthetic $tmp0_rcvr:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;FFZI)V
    .locals 0

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$tmp0_rcvr:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$parameters:Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    iput p3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$screenHeight:F

    iput p4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$borderPadding:F

    iput-boolean p5, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$isPhone:Z

    iput p6, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$$changed:I

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

    invoke-virtual {p0, p1, p2}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->invoke(Landroidx/compose/runtime/Composer;I)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Landroidx/compose/runtime/Composer;I)V
    .locals 7

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$tmp0_rcvr:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$parameters:Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    iget v2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$screenHeight:F

    iget v3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$borderPadding:F

    iget-boolean v4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$isPhone:Z

    iget p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreenUIPortrait$2;->$$changed:I

    or-int/lit8 v6, p2, 0x1

    move-object v5, p1

    invoke-virtual/range {v0 .. v6}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanScreenUIPortrait-WMci_g0(Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;FFZLandroidx/compose/runtime/Composer;I)V

    return-void
.end method
