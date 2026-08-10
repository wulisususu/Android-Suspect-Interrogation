.class public Lcom/taobao/tao/log/utils/SamplingRate;
.super Ljava/lang/Object;
.source "SamplingRate.java"


# instance fields
.field public sampling_ceil:I

.field public sampling_floor:I

.field public sampling_max_ceil:I

.field public sampling_rate:D


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method isValid()Z
    .locals 3

    iget v0, p0, Lcom/taobao/tao/log/utils/SamplingRate;->sampling_max_ceil:I

    if-lez v0, :cond_0

    iget v1, p0, Lcom/taobao/tao/log/utils/SamplingRate;->sampling_ceil:I

    if-ltz v1, :cond_0

    iget v2, p0, Lcom/taobao/tao/log/utils/SamplingRate;->sampling_floor:I

    if-ltz v2, :cond_0

    if-gt v1, v0, :cond_0

    if-gt v2, v0, :cond_0

    if-gt v2, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
