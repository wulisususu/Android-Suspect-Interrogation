.class final Lcom/aliyun/emas/apm/crash/internal/model/l$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/l;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:J

.field private c:Ljava/lang/Long;

.field private d:Z

.field private e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

.field private f:Ljava/util/List;

.field private g:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;-><init>()V

    return-void
.end method

.method private constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)V
    .locals 2

    .line 3
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;-><init>()V

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getIdentifier()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->a:Ljava/lang/String;

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getStartedAt()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->b:J

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getEndedAt()Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->c:Ljava/lang/Long;

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->isCrashed()Z

    move-result v0

    iput-boolean v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->d:Z

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getLog()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getEvents()Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->f:Ljava/util/List;

    const/4 p1, 0x3

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;Lcom/aliyun/emas/apm/crash/internal/model/l$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/l$b;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
    .locals 11

    iget-byte v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->a:Ljava/lang/String;

    if-nez v3, :cond_0

    goto :goto_0

    .line 15
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/l;

    iget-wide v4, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->b:J

    iget-object v6, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->c:Ljava/lang/Long;

    iget-boolean v7, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->d:Z

    iget-object v8, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    iget-object v9, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->f:Ljava/util/List;

    const/4 v10, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v10}, Lcom/aliyun/emas/apm/crash/internal/model/l;-><init>(Ljava/lang/String;JLjava/lang/Long;ZLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/l$a;)V

    return-object v0

    .line 16
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->a:Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v1, " identifier"

    .line 18
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    and-int/lit8 v1, v1, 0x1

    if-nez v1, :cond_3

    const-string v1, " startedAt"

    .line 21
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    and-int/lit8 v1, v1, 0x2

    if-nez v1, :cond_4

    const-string v1, " crashed"

    .line 24
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 26
    :cond_4
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

.method public setCrashed(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->d:Z

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    or-int/lit8 p1, p1, 0x2

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    return-object p0
.end method

.method public setEndedAt(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->c:Ljava/lang/Long;

    return-object p0
.end method

.method public setEvents(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->f:Ljava/util/List;

    return-object p0
.end method

.method public setIdentifier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->a:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null identifier"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setLog(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->e:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    return-object p0
.end method

.method public setStartedAt(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->b:J

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->g:B

    return-object p0
.end method
