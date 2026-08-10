.class final Lcom/aliyun/emas/apm/crash/internal/model/s$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/s;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:I

.field private d:Z

.field private e:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;
    .locals 8

    iget-byte v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    const/4 v1, 0x7

    if-ne v0, v1, :cond_1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->a:Ljava/lang/String;

    if-nez v3, :cond_0

    goto :goto_0

    .line 18
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/s;

    iget v4, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->b:I

    iget v5, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->c:I

    iget-boolean v6, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->d:Z

    const/4 v7, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v7}, Lcom/aliyun/emas/apm/crash/internal/model/s;-><init>(Ljava/lang/String;IIZLcom/aliyun/emas/apm/crash/internal/model/s$a;)V

    return-object v0

    .line 19
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->a:Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v1, " processName"

    .line 21
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    and-int/lit8 v1, v1, 0x1

    if-nez v1, :cond_3

    const-string v1, " pid"

    .line 24
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    and-int/lit8 v1, v1, 0x2

    if-nez v1, :cond_4

    const-string v1, " importance"

    .line 27
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_4
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    and-int/lit8 v1, v1, 0x4

    if-nez v1, :cond_5

    const-string v1, " defaultProcess"

    .line 30
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 32
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

.method public setDefaultProcess(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->d:Z

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    or-int/lit8 p1, p1, 0x4

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    return-object p0
.end method

.method public setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->c:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    or-int/lit8 p1, p1, 0x2

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    return-object p0
.end method

.method public setPid(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->b:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->e:B

    return-object p0
.end method

.method public setProcessName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/s$b;->a:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null processName"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
