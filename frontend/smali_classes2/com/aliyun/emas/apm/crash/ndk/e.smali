.class public Lcom/aliyun/emas/apm/crash/ndk/e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;


# instance fields
.field public final a:Lcom/aliyun/emas/apm/crash/ndk/d;


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/crash/ndk/d;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    return-void
.end method


# virtual methods
.method public getApplicationExitInto()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d;->a:Lcom/aliyun/emas/apm/crash/ndk/d$c;

    if-eqz v0, :cond_0

    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d$c;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public getBinaryImagesFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d;->b:Ljava/io/File;

    return-object v0
.end method

.method public getLogcatFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d;->e:Ljava/io/File;

    return-object v0
.end method

.method public getMetadataFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d;->c:Ljava/io/File;

    return-object v0
.end method

.method public getMinidumpFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d;->a:Lcom/aliyun/emas/apm/crash/ndk/d$c;

    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d$c;->a:Ljava/io/File;

    return-object v0
.end method

.method public getStatusFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/e;->a:Lcom/aliyun/emas/apm/crash/ndk/d;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/ndk/d;->d:Ljava/io/File;

    return-object v0
.end method
