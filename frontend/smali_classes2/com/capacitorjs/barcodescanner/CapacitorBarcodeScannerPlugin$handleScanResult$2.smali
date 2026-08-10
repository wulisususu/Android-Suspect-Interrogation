.class final Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBarcodePlugin.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->handleScanResult(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V
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
        "error",
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
.field final synthetic $call:Lcom/getcapacitor/PluginCall;

.field final synthetic this$0:Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;


# direct methods
.method constructor <init>(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;)V
    .locals 0

    iput-object p1, p0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;->$call:Lcom/getcapacitor/PluginCall;

    iput-object p2, p0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;->this$0:Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 60
    check-cast p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p0, p1}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;->invoke(Lcom/outsystems/plugins/barcode/model/OSBARCError;)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Lcom/outsystems/plugins/barcode/model/OSBARCError;)V
    .locals 3

    const-string v0, "error"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;->$call:Lcom/getcapacitor/PluginCall;

    .line 68
    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getDescription()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;->this$0:Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;

    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result p1

    invoke-static {v2, p1}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->access$formatErrorCode(Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
