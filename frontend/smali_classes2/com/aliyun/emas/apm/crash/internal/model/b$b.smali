.class final Lcom/aliyun/emas/apm/crash/internal/model/b$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

.field private h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

.field private i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

.field private j:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

.field private k:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

.field private l:Ljava/lang/Long;

.field private m:Ljava/lang/Long;

.field private n:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

.field private o:D

.field private p:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;-><init>()V

    return-void
.end method

.method private constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)V
    .locals 2

    .line 3
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;-><init>()V

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getProtocolVersion()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->a:Ljava/lang/String;

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPlatform()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->b:Ljava/lang/String;

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getEventId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->c:Ljava/lang/String;

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getUtdid()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->d:Ljava/lang/String;

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getSessionId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->e:Ljava/lang/String;

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getUuid()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->f:Ljava/lang/String;

    .line 10
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getSdk()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    .line 11
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    .line 12
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getDevice()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    .line 13
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getUser()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->j:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    .line 14
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getNetwork()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->k:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    .line 15
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getEventTime()Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->l:Ljava/lang/Long;

    .line 16
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getClientTime()Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->m:Ljava/lang/Long;

    .line 17
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->n:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    .line 18
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getSampleRate()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->o:D

    const/4 p1, 0x1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->p:B

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;Lcom/aliyun/emas/apm/crash/internal/model/b$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/b$b;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 22

    move-object/from16 v0, p0

    iget-byte v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->p:B

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->a:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->b:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->c:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->d:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->e:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->f:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    if-nez v1, :cond_0

    goto :goto_0

    .line 44
    :cond_0
    new-instance v1, Lcom/aliyun/emas/apm/crash/internal/model/b;

    move-object v3, v1

    iget-object v4, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->a:Ljava/lang/String;

    iget-object v5, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->b:Ljava/lang/String;

    iget-object v6, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->c:Ljava/lang/String;

    iget-object v7, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->d:Ljava/lang/String;

    iget-object v8, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->e:Ljava/lang/String;

    iget-object v9, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->f:Ljava/lang/String;

    iget-object v10, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    iget-object v11, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    iget-object v12, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    iget-object v13, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->j:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    iget-object v14, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->k:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    iget-object v15, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->l:Ljava/lang/Long;

    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->m:Ljava/lang/Long;

    move-object/from16 v16, v2

    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->n:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-object/from16 v17, v2

    move-object/from16 v21, v1

    iget-wide v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->o:D

    move-wide/from16 v18, v1

    const/16 v20, 0x0

    invoke-direct/range {v3 .. v20}, Lcom/aliyun/emas/apm/crash/internal/model/b;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;Ljava/lang/Long;Ljava/lang/Long;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;DLcom/aliyun/emas/apm/crash/internal/model/b$a;)V

    return-object v21

    .line 45
    :cond_1
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->a:Ljava/lang/String;

    if-nez v3, :cond_2

    const-string v3, " protocolVersion"

    .line 47
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->b:Ljava/lang/String;

    if-nez v3, :cond_3

    const-string v3, " platform"

    .line 50
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->c:Ljava/lang/String;

    if-nez v3, :cond_4

    const-string v3, " eventId"

    .line 53
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_4
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->d:Ljava/lang/String;

    if-nez v3, :cond_5

    const-string v3, " utdid"

    .line 56
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_5
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->e:Ljava/lang/String;

    if-nez v3, :cond_6

    const-string v3, " sessionId"

    .line 59
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_6
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->f:Ljava/lang/String;

    if-nez v3, :cond_7

    const-string v3, " uuid"

    .line 62
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_7
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    if-nez v3, :cond_8

    const-string v3, " sdk"

    .line 65
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_8
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    if-nez v3, :cond_9

    const-string v3, " app"

    .line 68
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_9
    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    if-nez v3, :cond_a

    const-string v3, " device"

    .line 71
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_a
    iget-byte v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->p:B

    and-int/2addr v2, v3

    if-nez v2, :cond_b

    const-string v2, " sampleRate"

    .line 74
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 76
    :cond_b
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Missing required properties:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->h:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null app"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setClientTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->m:Ljava/lang/Long;

    return-object p0
.end method

.method public setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->i:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null device"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setEventId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->c:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null eventId"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setEventTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->l:Ljava/lang/Long;

    return-object p0
.end method

.method public setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->k:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    return-object p0
.end method

.method public setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->n:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    return-object p0
.end method

.method public setPlatform(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->b:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null platform"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setProtocolVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->a:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null protocolVersion"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setSampleRate(D)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->o:D

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->p:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->p:B

    return-object p0
.end method

.method public setSdk(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null sdk"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setSessionId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->e:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null sessionId"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->j:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    return-object p0
.end method

.method public setUtdid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->d:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null utdid"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setUuid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;->f:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null uuid"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
