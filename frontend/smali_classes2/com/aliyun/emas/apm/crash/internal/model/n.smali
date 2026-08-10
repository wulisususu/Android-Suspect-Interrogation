.class final Lcom/aliyun/emas/apm/crash/internal/model/n;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/n$b;
    }
.end annotation


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

.field private final b:Ljava/util/List;

.field private final c:Ljava/util/List;

.field private final d:Ljava/lang/Boolean;

.field private final e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

.field private final f:Ljava/util/List;

.field private final g:I

.field private final h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

.field private final i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;


# direct methods
.method private constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;Ljava/util/List;Ljava/util/List;Ljava/lang/Boolean;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;Ljava/util/List;ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->b:Ljava/util/List;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->c:Ljava/util/List;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->d:Ljava/lang/Boolean;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->f:Ljava/util/List;

    iput p7, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->g:I

    iput-object p8, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    iput-object p9, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;Ljava/util/List;Ljava/util/List;Ljava/lang/Boolean;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;Ljava/util/List;ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;Lcom/aliyun/emas/apm/crash/internal/model/n$a;)V
    .locals 0

    .line 1
    invoke-direct/range {p0 .. p9}, Lcom/aliyun/emas/apm/crash/internal/model/n;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;Ljava/util/List;Ljava/util/List;Ljava/lang/Boolean;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;Ljava/util/List;ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)V

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
    instance-of v1, p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    const/4 v2, 0x0

    if-eqz v1, :cond_9

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getExecution()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->b:Ljava/util/List;

    if-nez v1, :cond_1

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getCustomAttributes()Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_8

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getCustomAttributes()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :goto_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->c:Ljava/util/List;

    if-nez v1, :cond_2

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getInternalKeys()Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_8

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getInternalKeys()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :goto_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->d:Ljava/lang/Boolean;

    if-nez v1, :cond_3

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getBackground()Ljava/lang/Boolean;

    move-result-object v1

    if-nez v1, :cond_8

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getBackground()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :goto_2
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    if-nez v1, :cond_4

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getCurrentProcessDetails()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object v1

    if-nez v1, :cond_8

    goto :goto_3

    :cond_4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getCurrentProcessDetails()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :goto_3
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->f:Ljava/util/List;

    if-nez v1, :cond_5

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getAppProcessDetails()Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_8

    goto :goto_4

    :cond_5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getAppProcessDetails()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :goto_4
    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->g:I

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getUiOrientation()I

    move-result v3

    if-ne v1, v3, :cond_8

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    if-nez v1, :cond_6

    .line 10
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getUser()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v1

    if-nez v1, :cond_8

    goto :goto_5

    :cond_6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getUser()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    :goto_5
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    if-nez v1, :cond_7

    .line 11
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getNetwork()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object p1

    if-nez p1, :cond_8

    goto :goto_6

    :cond_7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getNetwork()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_8

    goto :goto_6

    :cond_8
    move v0, v2

    :goto_6
    return v0

    :cond_9
    return v2
.end method

.method public getAppProcessDetails()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->f:Ljava/util/List;

    return-object v0
.end method

.method public getBackground()Ljava/lang/Boolean;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->d:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getCurrentProcessDetails()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    return-object v0
.end method

.method public getCustomAttributes()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->b:Ljava/util/List;

    return-object v0
.end method

.method public getExecution()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    return-object v0
.end method

.method public getInternalKeys()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->c:Ljava/util/List;

    return-object v0
.end method

.method public getNetwork()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    return-object v0
.end method

.method public getUiOrientation()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->g:I

    return v0
.end method

.method public getUser()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    .line 1
    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->b:Ljava/util/List;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    move v2, v3

    goto :goto_0

    .line 3
    :cond_0
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_0
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->c:Ljava/util/List;

    if-nez v2, :cond_1

    move v2, v3

    goto :goto_1

    .line 5
    :cond_1
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_1
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->d:Ljava/lang/Boolean;

    if-nez v2, :cond_2

    move v2, v3

    goto :goto_2

    .line 7
    :cond_2
    invoke-virtual {v2}, Ljava/lang/Boolean;->hashCode()I

    move-result v2

    :goto_2
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    if-nez v2, :cond_3

    move v2, v3

    goto :goto_3

    .line 9
    :cond_3
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_3
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->f:Ljava/util/List;

    if-nez v2, :cond_4

    move v2, v3

    goto :goto_4

    .line 11
    :cond_4
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_4
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->g:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    if-nez v2, :cond_5

    move v2, v3

    goto :goto_5

    .line 15
    :cond_5
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_5
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    if-nez v1, :cond_6

    goto :goto_6

    .line 17
    :cond_6
    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_6
    xor-int/2addr v0, v3

    return v0
.end method

.method public toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/n$b;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;Lcom/aliyun/emas/apm/crash/internal/model/n$a;)V

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Application{execution="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", customAttributes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->b:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", internalKeys="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->c:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", background="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->d:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", currentProcessDetails="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", appProcessDetails="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->f:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", uiOrientation="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->g:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", user="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", network="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
