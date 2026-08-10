.class final Lcom/aliyun/emas/apm/crash/internal/model/r;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/r$b;
    }
.end annotation


# instance fields
.field private final a:J

.field private final b:Ljava/lang/String;

.field private final c:Ljava/lang/String;

.field private final d:J

.field private final e:I


# direct methods
.method private constructor <init>(JLjava/lang/String;Ljava/lang/String;JI)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;-><init>()V

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->a:J

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->b:Ljava/lang/String;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->c:Ljava/lang/String;

    iput-wide p5, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->d:J

    iput p7, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->e:I

    return-void
.end method

.method synthetic constructor <init>(JLjava/lang/String;Ljava/lang/String;JILcom/aliyun/emas/apm/crash/internal/model/r$a;)V
    .locals 0

    .line 1
    invoke-direct/range {p0 .. p7}, Lcom/aliyun/emas/apm/crash/internal/model/r;-><init>(JLjava/lang/String;Ljava/lang/String;JI)V

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
    instance-of v1, p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    iget-wide v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->a:J

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->getPc()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->b:Ljava/lang/String;

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->getSymbol()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->c:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->getFile()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_2

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->getFile()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    :goto_0
    iget-wide v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->d:J

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->getOffset()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->e:I

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->getImportance()I

    move-result p1

    if-ne v1, p1, :cond_2

    goto :goto_1

    :cond_2
    move v0, v2

    :goto_1
    return v0

    :cond_3
    return v2
.end method

.method public getFile()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->c:Ljava/lang/String;

    return-object v0
.end method

.method public getImportance()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->e:I

    return v0
.end method

.method public getOffset()J
    .locals 2

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->d:J

    return-wide v0
.end method

.method public getPc()J
    .locals 2

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->a:J

    return-wide v0
.end method

.method public getSymbol()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->b:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 7

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->a:J

    const/16 v2, 0x20

    ushr-long v3, v0, v2

    xor-long/2addr v0, v3

    long-to-int v0, v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->b:Ljava/lang/String;

    .line 3
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    xor-int/2addr v0, v3

    mul-int/2addr v0, v1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->c:Ljava/lang/String;

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    .line 5
    :cond_0
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    xor-int/2addr v0, v3

    mul-int/2addr v0, v1

    iget-wide v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->d:J

    ushr-long v5, v3, v2

    xor-long v2, v5, v3

    long-to-int v2, v2

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->e:I

    xor-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Frame{pc="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->a:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", symbol="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", file="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", offset="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->d:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", importance="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/r;->e:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
