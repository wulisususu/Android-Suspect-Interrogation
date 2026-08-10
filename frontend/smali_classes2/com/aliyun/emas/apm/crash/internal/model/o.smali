.class final Lcom/aliyun/emas/apm/crash/internal/model/o;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/o$b;
    }
.end annotation


# instance fields
.field private final a:Ljava/util/List;

.field private final b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

.field private final c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

.field private final d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;


# direct methods
.method private constructor <init>(Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->a:Ljava/util/List;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    return-void
.end method

.method synthetic constructor <init>(Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/o$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/aliyun/emas/apm/crash/internal/model/o;-><init>(Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;)V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 1
    :cond_0
    instance-of v1, p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    const/4 v2, 0x0

    if-eqz v1, :cond_6

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->a:Ljava/util/List;

    if-nez v1, :cond_1

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getThreads()Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_5

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getThreads()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    :goto_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    if-nez v1, :cond_2

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getException()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getException()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    :goto_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    if-nez v1, :cond_3

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getAppExitInfo()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object v1

    if-nez v1, :cond_5

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getAppExitInfo()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    :goto_2
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    if-nez v1, :cond_4

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getNdkPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    move-result-object p1

    if-nez p1, :cond_5

    goto :goto_3

    :cond_4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->getNdkPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    goto :goto_3

    :cond_5
    move v0, v2

    :goto_3
    return v0

    :cond_6
    return v2
.end method

.method public getAppExitInfo()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    return-object v0
.end method

.method public getException()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    return-object v0
.end method

.method public getNdkPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    return-object v0
.end method

.method public getThreads()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->a:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->a:Ljava/util/List;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    .line 1
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    :goto_0
    const v2, 0xf4243

    xor-int/2addr v0, v2

    mul-int/2addr v0, v2

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    if-nez v3, :cond_1

    move v3, v1

    goto :goto_1

    .line 3
    :cond_1
    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_1
    xor-int/2addr v0, v3

    mul-int/2addr v0, v2

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    if-nez v3, :cond_2

    move v3, v1

    goto :goto_2

    .line 5
    :cond_2
    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_2
    xor-int/2addr v0, v3

    mul-int/2addr v0, v2

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    if-nez v2, :cond_3

    goto :goto_3

    .line 7
    :cond_3
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v1

    :goto_3
    xor-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Execution{threads="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->a:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", exception="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", appExitInfo="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", ndkPayload="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
