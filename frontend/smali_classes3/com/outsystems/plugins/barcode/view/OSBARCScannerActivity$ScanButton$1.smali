.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanButton$1;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanButton(Landroidx/compose/ui/Modifier;Ljava/lang/String;Landroidx/compose/runtime/Composer;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0008\n\u0000\n\u0002\u0010\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002"
    }
    d2 = {
        "<anonymous>",
        "",
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
.field final synthetic $scanning$delegate:Landroidx/compose/runtime/MutableState;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/compose/runtime/MutableState<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/compose/runtime/MutableState;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;",
            "Landroidx/compose/runtime/MutableState<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanButton$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanButton$1;->$scanning$delegate:Landroidx/compose/runtime/MutableState;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 746
    invoke-virtual {p0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanButton$1;->invoke()V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke()V
    .locals 2

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanButton$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 748
    invoke-static {v0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$isScanning$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$setScanning$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Z)V

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanButton$1;->$scanning$delegate:Landroidx/compose/runtime/MutableState;

    .line 749
    invoke-static {v0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$ScanButton$lambda$19(Landroidx/compose/runtime/MutableState;)Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$ScanButton$lambda$20(Landroidx/compose/runtime/MutableState;Z)V

    return-void
.end method
