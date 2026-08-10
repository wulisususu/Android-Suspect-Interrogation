.class public Landroidx/camera/camera2/internal/compat/workaround/UseFlashModeTorchFor3aUpdate;
.super Ljava/lang/Object;
.source "UseFlashModeTorchFor3aUpdate.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "UseFlashModeTorchFor3aUpdate"


# instance fields
.field private final mTorchFlashRequiredFor3AUpdateQuirk:Landroidx/camera/camera2/internal/compat/quirk/TorchFlashRequiredFor3aUpdateQuirk;


# direct methods
.method public constructor <init>(Landroidx/camera/core/impl/Quirks;)V
    .locals 1

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const-class v0, Landroidx/camera/camera2/internal/compat/quirk/TorchFlashRequiredFor3aUpdateQuirk;

    invoke-virtual {p1, v0}, Landroidx/camera/core/impl/Quirks;->get(Ljava/lang/Class;)Landroidx/camera/core/impl/Quirk;

    move-result-object p1

    check-cast p1, Landroidx/camera/camera2/internal/compat/quirk/TorchFlashRequiredFor3aUpdateQuirk;

    iput-object p1, p0, Landroidx/camera/camera2/internal/compat/workaround/UseFlashModeTorchFor3aUpdate;->mTorchFlashRequiredFor3AUpdateQuirk:Landroidx/camera/camera2/internal/compat/quirk/TorchFlashRequiredFor3aUpdateQuirk;

    return-void
.end method


# virtual methods
.method public shouldUseFlashModeTorch()Z
    .locals 3

    iget-object v0, p0, Landroidx/camera/camera2/internal/compat/workaround/UseFlashModeTorchFor3aUpdate;->mTorchFlashRequiredFor3AUpdateQuirk:Landroidx/camera/camera2/internal/compat/quirk/TorchFlashRequiredFor3aUpdateQuirk;

    if-eqz v0, :cond_0

    .line 43
    invoke-virtual {v0}, Landroidx/camera/camera2/internal/compat/quirk/TorchFlashRequiredFor3aUpdateQuirk;->isFlashModeTorchRequired()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 44
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string/jumbo v2, "shouldUseFlashModeTorch: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "UseFlashModeTorchFor3aUpdate"

    invoke-static {v2, v1}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    return v0
.end method
