.class final Lcom/aliyun/emas/apm/b;
.super Lcom/aliyun/emas/apm/StartupTime;
.source "SourceFile"


# instance fields
.field private final a:J

.field private final b:J

.field private final c:J


# direct methods
.method constructor <init>(JJJ)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/StartupTime;-><init>()V

    iput-wide p1, p0, Lcom/aliyun/emas/apm/b;->a:J

    iput-wide p3, p0, Lcom/aliyun/emas/apm/b;->b:J

    iput-wide p5, p0, Lcom/aliyun/emas/apm/b;->c:J

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 1
    :cond_0
    instance-of v1, p1, Lcom/aliyun/emas/apm/StartupTime;

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/StartupTime;

    iget-wide v3, p0, Lcom/aliyun/emas/apm/b;->a:J

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/StartupTime;->getEpochMillis()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_1

    iget-wide v3, p0, Lcom/aliyun/emas/apm/b;->b:J

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/StartupTime;->getElapsedRealtime()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_1

    iget-wide v3, p0, Lcom/aliyun/emas/apm/b;->c:J

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/StartupTime;->getUptimeMillis()J

    move-result-wide v5

    cmp-long p1, v3, v5

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    move v0, v2

    :goto_0
    return v0

    :cond_2
    return v2
.end method

.method public getElapsedRealtime()J
    .locals 2

    iget-wide v0, p0, Lcom/aliyun/emas/apm/b;->b:J

    return-wide v0
.end method

.method public getEpochMillis()J
    .locals 2

    iget-wide v0, p0, Lcom/aliyun/emas/apm/b;->a:J

    return-wide v0
.end method

.method public getUptimeMillis()J
    .locals 2

    iget-wide v0, p0, Lcom/aliyun/emas/apm/b;->c:J

    return-wide v0
.end method

.method public hashCode()I
    .locals 7

    iget-wide v0, p0, Lcom/aliyun/emas/apm/b;->a:J

    const/16 v2, 0x20

    ushr-long v3, v0, v2

    xor-long/2addr v0, v3

    long-to-int v0, v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-wide v3, p0, Lcom/aliyun/emas/apm/b;->b:J

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v3, v3

    xor-int/2addr v0, v3

    mul-int/2addr v0, v1

    iget-wide v3, p0, Lcom/aliyun/emas/apm/b;->c:J

    ushr-long v1, v3, v2

    xor-long/2addr v1, v3

    long-to-int v1, v1

    xor-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "StartupTime{epochMillis="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lcom/aliyun/emas/apm/b;->a:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", elapsedRealtime="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/aliyun/emas/apm/b;->b:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", uptimeMillis="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/aliyun/emas/apm/b;->c:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
