.class public Landroidx/camera/core/ImageCaptureLatencyEstimate;
.super Ljava/lang/Object;
.source "ImageCaptureLatencyEstimate.java"


# static fields
.field public static final UNDEFINED_CAPTURE_LATENCY:J = -0x1L

.field public static final UNDEFINED_IMAGE_CAPTURE_LATENCY:Landroidx/camera/core/ImageCaptureLatencyEstimate;

.field public static final UNDEFINED_PROCESSING_LATENCY:J = -0x1L


# instance fields
.field private final mCaptureLatencyMillis:J

.field private final mProcessingLatencyMillis:J

.field private final mTotalCaptureLatencyMillis:J


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 42
    new-instance v0, Landroidx/camera/core/ImageCaptureLatencyEstimate;

    const-wide/16 v1, -0x1

    invoke-direct {v0, v1, v2, v1, v2}, Landroidx/camera/core/ImageCaptureLatencyEstimate;-><init>(JJ)V

    sput-object v0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->UNDEFINED_IMAGE_CAPTURE_LATENCY:Landroidx/camera/core/ImageCaptureLatencyEstimate;

    return-void
.end method

.method public constructor <init>(JJ)V
    .locals 0

    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mCaptureLatencyMillis:J

    iput-wide p3, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mProcessingLatencyMillis:J

    .line 65
    invoke-direct {p0, p1, p2, p3, p4}, Landroidx/camera/core/ImageCaptureLatencyEstimate;->computeTotalCaptureLatencyMillis(JJ)J

    move-result-wide p1

    iput-wide p1, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mTotalCaptureLatencyMillis:J

    return-void
.end method

.method private computeTotalCaptureLatencyMillis(JJ)J
    .locals 3

    const-wide/16 v0, -0x1

    cmp-long v2, p1, v0

    if-eqz v2, :cond_1

    cmp-long v2, p3, v0

    if-nez v2, :cond_0

    goto :goto_0

    :cond_0
    add-long/2addr p1, p3

    return-wide p1

    :cond_1
    :goto_0
    return-wide v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 101
    :cond_0
    instance-of v1, p1, Landroidx/camera/core/ImageCaptureLatencyEstimate;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 102
    :cond_1
    check-cast p1, Landroidx/camera/core/ImageCaptureLatencyEstimate;

    iget-wide v3, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mCaptureLatencyMillis:J

    .line 103
    invoke-virtual {p1}, Landroidx/camera/core/ImageCaptureLatencyEstimate;->getCaptureLatencyMillis()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget-wide v3, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mProcessingLatencyMillis:J

    .line 104
    invoke-virtual {p1}, Landroidx/camera/core/ImageCaptureLatencyEstimate;->getProcessingLatencyMillis()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget-wide v3, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mTotalCaptureLatencyMillis:J

    .line 105
    invoke-virtual {p1}, Landroidx/camera/core/ImageCaptureLatencyEstimate;->getTotalCaptureLatencyMillis()J

    move-result-wide v5

    cmp-long p1, v3, v5

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    move v0, v2

    :goto_0
    return v0
.end method

.method public getCaptureLatencyMillis()J
    .locals 2

    iget-wide v0, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mCaptureLatencyMillis:J

    return-wide v0
.end method

.method public getProcessingLatencyMillis()J
    .locals 2

    iget-wide v0, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mProcessingLatencyMillis:J

    return-wide v0
.end method

.method public getTotalCaptureLatencyMillis()J
    .locals 2

    iget-wide v0, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mTotalCaptureLatencyMillis:J

    return-wide v0
.end method

.method public hashCode()I
    .locals 4

    iget-wide v0, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mCaptureLatencyMillis:J

    .line 110
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iget-wide v1, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mProcessingLatencyMillis:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    iget-wide v2, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mTotalCaptureLatencyMillis:J

    .line 111
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    .line 110
    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 117
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "captureLatencyMillis="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mCaptureLatencyMillis:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", processingLatencyMillis="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mProcessingLatencyMillis:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalCaptureLatencyMillis="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Landroidx/camera/core/ImageCaptureLatencyEstimate;->mTotalCaptureLatencyMillis:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
