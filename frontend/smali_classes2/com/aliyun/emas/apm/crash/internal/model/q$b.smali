.class final Lcom/aliyun/emas/apm/crash/internal/model/q$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/q;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:I

.field private c:Ljava/util/List;

.field private d:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;
    .locals 5

    iget-byte v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->d:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->a:Ljava/lang/String;

    if-nez v0, :cond_0

    goto :goto_0

    .line 12
    :cond_0
    new-instance v1, Lcom/aliyun/emas/apm/crash/internal/model/q;

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->b:I

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->c:Ljava/util/List;

    const/4 v4, 0x0

    invoke-direct {v1, v0, v2, v3, v4}, Lcom/aliyun/emas/apm/crash/internal/model/q;-><init>(Ljava/lang/String;ILjava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/q$a;)V

    return-object v1

    .line 13
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->a:Ljava/lang/String;

    if-nez v2, :cond_2

    const-string v2, " name"

    .line 15
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-byte v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->d:B

    and-int/2addr v1, v2

    if-nez v1, :cond_3

    const-string v1, " importance"

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

.method public setFrames(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->c:Ljava/util/List;

    return-object p0
.end method

.method public setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->b:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->d:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->d:B

    return-object p0
.end method

.method public setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/q$b;->a:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null name"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
