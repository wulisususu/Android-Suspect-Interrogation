.class final Lcom/aliyun/emas/apm/crash/internal/model/n$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/n;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

.field private b:Ljava/util/List;

.field private c:Ljava/util/List;

.field private d:Ljava/lang/Boolean;

.field private e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

.field private f:Ljava/util/List;

.field private g:I

.field private h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

.field private i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

.field private j:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;-><init>()V

    return-void
.end method

.method private constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)V
    .locals 1

    .line 3
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;-><init>()V

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getExecution()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getCustomAttributes()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->b:Ljava/util/List;

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getInternalKeys()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->c:Ljava/util/List;

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getBackground()Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->d:Ljava/lang/Boolean;

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getCurrentProcessDetails()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getAppProcessDetails()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->f:Ljava/util/List;

    .line 10
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getUiOrientation()I

    move-result v0

    iput v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->g:I

    .line 11
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getUser()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    .line 12
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->getNetwork()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    const/4 p1, 0x1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->j:B

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;Lcom/aliyun/emas/apm/crash/internal/model/n$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/n$b;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
    .locals 13

    iget-byte v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->j:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    if-nez v3, :cond_0

    goto :goto_0

    .line 12
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/n;

    iget-object v4, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->b:Ljava/util/List;

    iget-object v5, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->c:Ljava/util/List;

    iget-object v6, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->d:Ljava/lang/Boolean;

    iget-object v7, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    iget-object v8, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->f:Ljava/util/List;

    iget v9, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->g:I

    iget-object v10, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    iget-object v11, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    const/4 v12, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v12}, Lcom/aliyun/emas/apm/crash/internal/model/n;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;Ljava/util/List;Ljava/util/List;Ljava/lang/Boolean;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;Ljava/util/List;ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;Lcom/aliyun/emas/apm/crash/internal/model/n$a;)V

    return-object v0

    .line 13
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    if-nez v2, :cond_2

    const-string v2, " execution"

    .line 15
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-byte v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->j:B

    and-int/2addr v1, v2

    if-nez v1, :cond_3

    const-string v1, " uiOrientation"

    .line 18
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 20
    :cond_3
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Missing required properties:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public setAppProcessDetails(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->f:Ljava/util/List;

    return-object p0
.end method

.method public setBackground(Ljava/lang/Boolean;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->d:Ljava/lang/Boolean;

    return-object p0
.end method

.method public setCurrentProcessDetails(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    return-object p0
.end method

.method public setCustomAttributes(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->b:Ljava/util/List;

    return-object p0
.end method

.method public setExecution(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null execution"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setInternalKeys(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->c:Ljava/util/List;

    return-object p0
.end method

.method public setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    return-object p0
.end method

.method public setUiOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->g:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->j:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->j:B

    return-object p0
.end method

.method public setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/n$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    return-object p0
.end method
