.class public final Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;
.super Lcom/getcapacitor/Plugin;
.source "OSBarcodePlugin.kt"


# annotations
.annotation runtime Lcom/getcapacitor/annotation/CapacitorPlugin;
    name = "CapacitorBarcodeScanner"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008\u0007\u0018\u0000 \u00112\u00020\u0001:\u0001\u0011B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008H\u0002J\u0018\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0007J\u0008\u0010\u000f\u001a\u00020\nH\u0016J\u0010\u0010\u0010\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000cH\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082.\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;",
        "Lcom/getcapacitor/Plugin;",
        "()V",
        "barcodeController",
        "Lcom/outsystems/plugins/barcode/controller/OSBARCController;",
        "formatErrorCode",
        "",
        "code",
        "",
        "handleScanResult",
        "",
        "call",
        "Lcom/getcapacitor/PluginCall;",
        "result",
        "Landroidx/activity/result/ActivityResult;",
        "load",
        "scanBarcode",
        "Companion",
        "capacitor-barcode-scanner_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final Companion:Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$Companion;

.field private static final ERROR_FORMAT_PREFIX:Ljava/lang/String; = "OS-PLUG-BARC-"

.field private static final SCAN_REQUEST_CODE:I = 0x70


# instance fields
.field private barcodeController:Lcom/outsystems/plugins/barcode/controller/OSBARCController;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->Companion:Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Lcom/getcapacitor/Plugin;-><init>()V

    return-void
.end method

.method public static final synthetic access$formatErrorCode(Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;I)Ljava/lang/String;
    .locals 0

    .line 15
    invoke-direct {p0, p1}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->formatErrorCode(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private final formatErrorCode(I)Ljava/lang/String;
    .locals 2

    .line 74
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x4

    const/16 v1, 0x30

    invoke-static {p1, v0, v1}, Lkotlin/text/StringsKt;->padStart(Ljava/lang/String;IC)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "OS-PLUG-BARC-"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public final handleScanResult(Lcom/getcapacitor/PluginCall;Landroidx/activity/result/ActivityResult;)V
    .locals 7
    .annotation runtime Lcom/getcapacitor/annotation/ActivityCallback;
    .end annotation

    const-string v0, "call"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "result"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->barcodeController:Lcom/outsystems/plugins/barcode/controller/OSBARCController;

    if-nez v0, :cond_0

    const-string v0, "barcodeController"

    .line 60
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    move-object v1, v0

    const/16 v2, 0x70

    .line 61
    invoke-virtual {p2}, Landroidx/activity/result/ActivityResult;->getResultCode()I

    move-result v3

    invoke-virtual {p2}, Landroidx/activity/result/ActivityResult;->getData()Landroid/content/Intent;

    move-result-object v4

    .line 60
    new-instance p2, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$1;

    invoke-direct {p2, p1}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$1;-><init>(Lcom/getcapacitor/PluginCall;)V

    move-object v5, p2

    check-cast v5, Lkotlin/jvm/functions/Function1;

    new-instance p2, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;

    invoke-direct {p2, p1, p0}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin$handleScanResult$2;-><init>(Lcom/getcapacitor/PluginCall;Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;)V

    move-object v6, p2

    check-cast v6, Lkotlin/jvm/functions/Function1;

    invoke-virtual/range {v1 .. v6}, Lcom/outsystems/plugins/barcode/controller/OSBARCController;->handleActivityResult(IILandroid/content/Intent;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method public load()V
    .locals 1

    .line 25
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->load()V

    .line 26
    new-instance v0, Lcom/outsystems/plugins/barcode/controller/OSBARCController;

    invoke-direct {v0}, Lcom/outsystems/plugins/barcode/controller/OSBARCController;-><init>()V

    iput-object v0, p0, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->barcodeController:Lcom/outsystems/plugins/barcode/controller/OSBARCController;

    return-void
.end method

.method public final scanBarcode(Lcom/getcapacitor/PluginCall;)V
    .locals 10
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "call"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hint"

    .line 31
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getInt(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v7

    const-string v0, "scanInstructions"

    .line 32
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x0

    .line 33
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    const-string v1, "scanButton"

    invoke-virtual {p1, v1, v0}, Lcom/getcapacitor/PluginCall;->getBoolean(Ljava/lang/String;Ljava/lang/Boolean;)Ljava/lang/Boolean;

    move-result-object v0

    const-string v1, "scanText"

    const-string v3, ""

    .line 34
    invoke-virtual {p1, v1, v3}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v1, "cameraDirection"

    .line 35
    invoke-virtual {p1, v1}, Lcom/getcapacitor/PluginCall;->getInt(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v3

    const-string v1, "native"

    .line 37
    invoke-virtual {p1, v1}, Lcom/getcapacitor/PluginCall;->getObject(Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    move-result-object v1

    const/4 v4, 0x0

    if-eqz v1, :cond_0

    const-string v5, "scanOrientation"

    .line 39
    invoke-virtual {v1, v5}, Lcom/getcapacitor/JSObject;->getInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    goto :goto_0

    :cond_0
    move-object v5, v4

    :goto_0
    if-eqz v1, :cond_1

    const-string v8, "android"

    .line 40
    invoke-virtual {v1, v8}, Lcom/getcapacitor/JSObject;->getJSObject(Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    move-result-object v1

    if-eqz v1, :cond_1

    const-string v4, "scanningLibrary"

    invoke-virtual {v1, v4}, Lcom/getcapacitor/JSObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object v8, v1

    goto :goto_1

    :cond_1
    move-object v8, v4

    .line 42
    :goto_1
    new-instance v9, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    .line 46
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 47
    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    move-object v1, v9

    move-object v4, v5

    move v5, v0

    .line 42
    invoke-direct/range {v1 .. v8}, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;-><init>(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)V

    .line 52
    new-instance v0, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "SCAN_PARAMETERS"

    .line 53
    check-cast v9, Ljava/io/Serializable;

    invoke-virtual {v0, v1, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "putExtra(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "handleScanResult"

    .line 55
    invoke-virtual {p0, p1, v0, v1}, Lcom/capacitorjs/barcodescanner/CapacitorBarcodeScannerPlugin;->startActivityForResult(Lcom/getcapacitor/PluginCall;Landroid/content/Intent;Ljava/lang/String;)V

    return-void
.end method
