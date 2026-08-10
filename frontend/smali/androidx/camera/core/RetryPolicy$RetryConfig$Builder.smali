.class public final Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;
.super Ljava/lang/Object;
.source "RetryPolicy.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/RetryPolicy$RetryConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private mShouldRetry:Z

.field private mTimeoutInMillis:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 472
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;->mShouldRetry:Z

    .line 475
    invoke-static {}, Landroidx/camera/core/RetryPolicy$RetryConfig;->getDefaultRetryDelayInMillis()J

    move-result-wide v0

    iput-wide v0, p0, Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;->mTimeoutInMillis:J

    return-void
.end method


# virtual methods
.method public build()Landroidx/camera/core/RetryPolicy$RetryConfig;
    .locals 5

    .line 515
    new-instance v0, Landroidx/camera/core/RetryPolicy$RetryConfig;

    iget-boolean v1, p0, Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;->mShouldRetry:Z

    iget-wide v2, p0, Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;->mTimeoutInMillis:J

    const/4 v4, 0x0

    invoke-direct {v0, v1, v2, v3, v4}, Landroidx/camera/core/RetryPolicy$RetryConfig;-><init>(ZJLandroidx/camera/core/RetryPolicy$1;)V

    return-object v0
.end method

.method public setRetryDelayInMillis(J)Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;
    .locals 0

    iput-wide p1, p0, Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;->mTimeoutInMillis:J

    return-object p0
.end method

.method public setShouldRetry(Z)Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Landroidx/camera/core/RetryPolicy$RetryConfig$Builder;->mShouldRetry:Z

    return-object p0
.end method
