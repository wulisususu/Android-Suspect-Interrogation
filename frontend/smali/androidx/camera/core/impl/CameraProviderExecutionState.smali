.class public final Landroidx/camera/core/impl/CameraProviderExecutionState;
.super Ljava/lang/Object;
.source "CameraProviderExecutionState.java"

# interfaces
.implements Landroidx/camera/core/RetryPolicy$ExecutionState;


# instance fields
.field private final mAttemptCount:I

.field private final mCause:Ljava/lang/Throwable;

.field private final mStatus:I

.field private final mTaskExecutedTimeInMillis:J


# direct methods
.method public constructor <init>(JILjava/lang/Throwable;)V
    .locals 2

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sub-long/2addr v0, p1

    iput-wide v0, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mTaskExecutedTimeInMillis:J

    iput p3, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mAttemptCount:I

    .line 54
    instance-of p1, p4, Landroidx/camera/core/impl/CameraValidator$CameraIdListIncorrectException;

    const/4 p2, 0x2

    if-eqz p1, :cond_0

    iput p2, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mStatus:I

    iput-object p4, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mCause:Ljava/lang/Throwable;

    goto :goto_0

    .line 57
    :cond_0
    instance-of p1, p4, Landroidx/camera/core/InitializationException;

    const/4 p3, 0x0

    if-eqz p1, :cond_4

    .line 58
    invoke-virtual {p4}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object p1

    if-eqz p1, :cond_1

    move-object p4, p1

    :cond_1
    iput-object p4, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mCause:Ljava/lang/Throwable;

    .line 60
    instance-of p1, p4, Landroidx/camera/core/CameraUnavailableException;

    if-eqz p1, :cond_2

    iput p2, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mStatus:I

    goto :goto_0

    .line 62
    :cond_2
    instance-of p1, p4, Ljava/lang/IllegalArgumentException;

    if-eqz p1, :cond_3

    const/4 p1, 0x1

    iput p1, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mStatus:I

    goto :goto_0

    :cond_3
    iput p3, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mStatus:I

    goto :goto_0

    :cond_4
    iput p3, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mStatus:I

    iput-object p4, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mCause:Ljava/lang/Throwable;

    :goto_0
    return-void
.end method


# virtual methods
.method public getCause()Ljava/lang/Throwable;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mCause:Ljava/lang/Throwable;

    return-object v0
.end method

.method public getExecutedTimeInMillis()J
    .locals 2

    iget-wide v0, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mTaskExecutedTimeInMillis:J

    return-wide v0
.end method

.method public getNumOfAttempts()I
    .locals 1

    iget v0, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mAttemptCount:I

    return v0
.end method

.method public getStatus()I
    .locals 1

    iget v0, p0, Landroidx/camera/core/impl/CameraProviderExecutionState;->mStatus:I

    return v0
.end method
