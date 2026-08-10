.class final Lcom/aliyun/emas/apm/crash/internal/model/i$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:[B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/i$b;->a:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/i$b;->b:[B

    if-nez v1, :cond_0

    goto :goto_0

    .line 12
    :cond_0
    new-instance v2, Lcom/aliyun/emas/apm/crash/internal/model/i;

    const/4 v3, 0x0

    invoke-direct {v2, v0, v1, v3}, Lcom/aliyun/emas/apm/crash/internal/model/i;-><init>(Ljava/lang/String;[BLcom/aliyun/emas/apm/crash/internal/model/i$a;)V

    return-object v2

    .line 13
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/i$b;->a:Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v1, " filename"

    .line 15
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/i$b;->b:[B

    if-nez v1, :cond_3

    const-string v1, " contents"

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

.method public setContents([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/i$b;->b:[B

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null contents"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setFilename(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/i$b;->a:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null filename"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
