.class final Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCCameraPermissionDialog.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt;->CameraPermissionRequiredDialog(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;ZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroidx/compose/runtime/Composer;I)V
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

.field final synthetic $confirmButtonText:Ljava/lang/String;

.field final synthetic $dialogText:Ljava/lang/String;

.field final synthetic $dialogTitle:Ljava/lang/String;

.field final synthetic $dismissButtonText:Ljava/lang/String;

.field final synthetic $onConfirmation:Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $onDismissRequest:Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $permissionGiven:Z

.field final synthetic $shouldShowDialog:Z


# direct methods
.method constructor <init>(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;ZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;ZZ",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$onDismissRequest:Lkotlin/jvm/functions/Function0;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$onConfirmation:Lkotlin/jvm/functions/Function0;

    iput-boolean p3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$permissionGiven:Z

    iput-boolean p4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$shouldShowDialog:Z

    iput-object p5, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$dialogTitle:Ljava/lang/String;

    iput-object p6, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$dialogText:Ljava/lang/String;

    iput-object p7, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$confirmButtonText:Ljava/lang/String;

    iput-object p8, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$dismissButtonText:Ljava/lang/String;

    iput p9, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$$changed:I

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

    invoke-virtual {p0, p1, p2}, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->invoke(Landroidx/compose/runtime/Composer;I)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Landroidx/compose/runtime/Composer;I)V
    .locals 10

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$onDismissRequest:Lkotlin/jvm/functions/Function0;

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$onConfirmation:Lkotlin/jvm/functions/Function0;

    iget-boolean v2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$permissionGiven:Z

    iget-boolean v3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$shouldShowDialog:Z

    iget-object v4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$dialogTitle:Ljava/lang/String;

    iget-object v5, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$dialogText:Ljava/lang/String;

    iget-object v6, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$confirmButtonText:Ljava/lang/String;

    iget-object v7, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$dismissButtonText:Ljava/lang/String;

    iget p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt$CameraPermissionRequiredDialog$6;->$$changed:I

    or-int/lit8 v9, p2, 0x1

    move-object v8, p1

    invoke-static/range {v0 .. v9}, Lcom/outsystems/plugins/barcode/view/OSBARCCameraPermissionDialogKt;->CameraPermissionRequiredDialog(Lkotlin/jvm/functions/Function0;Lkotlin/jvm/functions/Function0;ZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroidx/compose/runtime/Composer;I)V

    return-void
.end method
