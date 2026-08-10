.class final Lcom/aliyun/emas/apm/crash/internal/model/m$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/m;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:J

.field private b:Ljava/lang/String;

.field private c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

.field private d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

.field private e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

.field private f:[B

.field private g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

.field private h:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;-><init>()V

    return-void
.end method

.method private constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;)V
    .locals 2

    .line 3
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;-><init>()V

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->a:J

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getType()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->b:Ljava/lang/String;

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getDevice()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getMemory()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getLogcat()[B

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->f:[B

    .line 10
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getRollouts()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    const/4 p1, 0x1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->h:B

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/internal/model/m$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/m$b;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;)V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 12

    iget-byte v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->h:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v5, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->b:Ljava/lang/String;

    if-eqz v5, :cond_1

    iget-object v6, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    if-eqz v6, :cond_1

    iget-object v7, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    if-nez v7, :cond_0

    goto :goto_0

    .line 20
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/m;

    iget-wide v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->a:J

    iget-object v8, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    iget-object v9, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->f:[B

    iget-object v10, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    const/4 v11, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v11}, Lcom/aliyun/emas/apm/crash/internal/model/m;-><init>(JLjava/lang/String;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;[BLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;Lcom/aliyun/emas/apm/crash/internal/model/m$a;)V

    return-object v0

    .line 21
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-byte v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->h:B

    and-int/2addr v1, v2

    if-nez v1, :cond_2

    const-string v1, " timestamp"

    .line 23
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->b:Ljava/lang/String;

    if-nez v1, :cond_3

    const-string v1, " type"

    .line 26
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    if-nez v1, :cond_4

    const-string v1, " app"

    .line 29
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_4
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    if-nez v1, :cond_5

    const-string v1, " device"

    .line 32
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 34
    :cond_5
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

.method public setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null app"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null device"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setLogcat([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->f:[B

    return-object p0
.end method

.method public setMemory(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    return-object p0
.end method

.method public setRollouts(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->g:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    return-object p0
.end method

.method public setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->a:J

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->h:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->h:B

    return-object p0
.end method

.method public setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;->b:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null type"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
