.class public Landroidx/camera/camera2/internal/compat/workaround/SessionResetPolicy;
.super Ljava/lang/Object;
.source "SessionResetPolicy.java"


# instance fields
.field private final mNeedAbortCapture:Z


# direct methods
.method public constructor <init>(Landroidx/camera/core/impl/Quirks;)V
    .locals 1

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const-class v0, Landroidx/camera/camera2/internal/compat/quirk/Preview3AThreadCrashQuirk;

    invoke-virtual {p1, v0}, Landroidx/camera/core/impl/Quirks;->contains(Ljava/lang/Class;)Z

    move-result p1

    iput-boolean p1, p0, Landroidx/camera/camera2/internal/compat/workaround/SessionResetPolicy;->mNeedAbortCapture:Z

    return-void
.end method


# virtual methods
.method public needAbortCapture()Z
    .locals 1

    iget-boolean v0, p0, Landroidx/camera/camera2/internal/compat/workaround/SessionResetPolicy;->mNeedAbortCapture:Z

    return v0
.end method
