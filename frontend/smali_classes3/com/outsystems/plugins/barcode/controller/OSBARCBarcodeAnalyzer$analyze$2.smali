.class final Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$2;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCBarcodeAnalyzer.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->analyze(Landroidx/camera/core/ImageProxy;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
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
.field final synthetic this$0:Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;)V
    .locals 0

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$2;->this$0:Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 38
    check-cast p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p0, p1}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$2;->invoke(Lcom/outsystems/plugins/barcode/model/OSBARCError;)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Lcom/outsystems/plugins/barcode/model/OSBARCError;)V
    .locals 1

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$2;->this$0:Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;

    .line 45
    invoke-static {v0}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->access$getOnScanningError$p(Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;)Lkotlin/jvm/functions/Function1;

    move-result-object v0

    invoke-interface {v0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
