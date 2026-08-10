.class final Lcom/aliyun/emas/apm/crash/internal/model/l;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/l$b;
    }
.end annotation


# instance fields
.field private final a:Ljava/lang/String;

.field private final b:J

.field private final c:Ljava/lang/Long;

.field private final d:Z

.field private final e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

.field private final f:Ljava/util/List;


# direct methods
.method private constructor <init>(Ljava/lang/String;JLjava/lang/Long;ZLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;Ljava/util/List;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->a:Ljava/lang/String;

    iput-wide p2, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->b:J

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->c:Ljava/lang/Long;

    iput-boolean p5, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->d:Z

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    iput-object p7, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->f:Ljava/util/List;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;JLjava/lang/Long;ZLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/l$a;)V
    .locals 0

    .line 1
    invoke-direct/range {p0 .. p7}, Lcom/aliyun/emas/apm/crash/internal/model/l;-><init>(Ljava/lang/String;JLjava/lang/Long;ZLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;Ljava/util/List;)V

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
    instance-of v1, p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    const/4 v2, 0x0

    if-eqz v1, :cond_5

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->a:Ljava/lang/String;

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getIdentifier()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-wide v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->b:J

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getStartedAt()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->c:Ljava/lang/Long;

    if-nez v1, :cond_1

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getEndedAt()Ljava/lang/Long;

    move-result-object v1

    if-nez v1, :cond_4

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getEndedAt()Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Long;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    :goto_0
    iget-boolean v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->d:Z

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->isCrashed()Z

    move-result v3

    if-ne v1, v3, :cond_4

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    if-nez v1, :cond_2

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getLog()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    move-result-object v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getLog()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    :goto_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->f:Ljava/util/List;

    if-nez v1, :cond_3

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getEvents()Ljava/util/List;

    move-result-object p1

    if-nez p1, :cond_4

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getEvents()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    goto :goto_2

    :cond_4
    move v0, v2

    :goto_2
    return v0

    :cond_5
    return v2
.end method

.method public getEndedAt()Ljava/lang/Long;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->c:Ljava/lang/Long;

    return-object v0
.end method

.method public getEvents()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->f:Ljava/util/List;

    return-object v0
.end method

.method public getIdentifier()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->a:Ljava/lang/String;

    return-object v0
.end method

.method public getLog()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    return-object v0
.end method

.method public getStartedAt()J
    .locals 2

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->b:J

    return-wide v0
.end method

.method public hashCode()I
    .locals 6

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->a:Ljava/lang/String;

    .line 1
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-wide v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->b:J

    const/16 v4, 0x20

    ushr-long v4, v2, v4

    xor-long/2addr v2, v4

    long-to-int v2, v2

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->c:Ljava/lang/Long;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    move v2, v3

    goto :goto_0

    .line 5
    :cond_0
    invoke-virtual {v2}, Ljava/lang/Long;->hashCode()I

    move-result v2

    :goto_0
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-boolean v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->d:Z

    if-eqz v2, :cond_1

    const/16 v2, 0x4cf

    goto :goto_1

    :cond_1
    const/16 v2, 0x4d5

    :goto_1
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    if-nez v2, :cond_2

    move v2, v3

    goto :goto_2

    .line 9
    :cond_2
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_2
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->f:Ljava/util/List;

    if-nez v1, :cond_3

    goto :goto_3

    .line 11
    :cond_3
    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_3
    xor-int/2addr v0, v3

    return v0
.end method

.method public isCrashed()Z
    .locals 1

    iget-boolean v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->d:Z

    return v0
.end method

.method public toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/l$b;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;Lcom/aliyun/emas/apm/crash/internal/model/l$a;)V

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Session{identifier="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", startedAt="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->b:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", endedAt="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->c:Ljava/lang/Long;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", crashed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->d:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", log="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", events="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l;->f:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
