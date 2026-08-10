.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanScreen(Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;Landroidx/compose/material3/windowsizeclass/WindowSizeClass;Landroidx/compose/runtime/Composer;I)V
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
.field final synthetic $requestPermissionLauncher:Landroidx/activity/compose/ManagedActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/compose/ManagedActivityResultLauncher<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/activity/compose/ManagedActivityResultLauncher;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;",
            "Landroidx/activity/compose/ManagedActivityResultLauncher<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;->$requestPermissionLauncher:Landroidx/activity/compose/ManagedActivityResultLauncher;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 240
    invoke-virtual {p0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;->invoke()V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke()V
    .locals 2

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 241
    invoke-static {v0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$getPermissionRequestCount$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 242
    invoke-static {v0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$getPermissionRequestCount$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$setPermissionRequestCount$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;I)V

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$1;->$requestPermissionLauncher:Landroidx/activity/compose/ManagedActivityResultLauncher;

    const-string v1, "android.permission.CAMERA"

    .line 243
    invoke-virtual {v0, v1}, Landroidx/activity/compose/ManagedActivityResultLauncher;->launch(Ljava/lang/Object;)V

    :cond_0
    return-void
.end method
