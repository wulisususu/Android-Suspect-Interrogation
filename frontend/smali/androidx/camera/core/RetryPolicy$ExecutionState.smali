.class public interface abstract Landroidx/camera/core/RetryPolicy$ExecutionState;
.super Ljava/lang/Object;
.source "RetryPolicy.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/RetryPolicy;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "ExecutionState"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/RetryPolicy$ExecutionState$Status;
    }
.end annotation


# static fields
.field public static final STATUS_CAMERA_UNAVAILABLE:I = 0x2

.field public static final STATUS_CONFIGURATION_FAIL:I = 0x1

.field public static final STATUS_UNKNOWN_ERROR:I


# virtual methods
.method public abstract getCause()Ljava/lang/Throwable;
.end method

.method public abstract getExecutedTimeInMillis()J
.end method

.method public abstract getNumOfAttempts()I
.end method

.method public abstract getStatus()I
.end method
