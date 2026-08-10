.class public final Lcom/aliyun/emas/apm/crash/ndk/d;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/ndk/d$b;,
        Lcom/aliyun/emas/apm/crash/ndk/d$c;
    }
.end annotation


# instance fields
.field public final a:Lcom/aliyun/emas/apm/crash/ndk/d$c;

.field public final b:Ljava/io/File;

.field public final c:Ljava/io/File;

.field public final d:Ljava/io/File;

.field public final e:Ljava/io/File;


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/crash/ndk/d$b;)V
    .locals 1

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/ndk/d$b;->a(Lcom/aliyun/emas/apm/crash/ndk/d$b;)Lcom/aliyun/emas/apm/crash/ndk/d$c;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/d;->a:Lcom/aliyun/emas/apm/crash/ndk/d$c;

    .line 4
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/ndk/d$b;->b(Lcom/aliyun/emas/apm/crash/ndk/d$b;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/d;->b:Ljava/io/File;

    .line 5
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/ndk/d$b;->c(Lcom/aliyun/emas/apm/crash/ndk/d$b;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/d;->c:Ljava/io/File;

    .line 6
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/ndk/d$b;->d(Lcom/aliyun/emas/apm/crash/ndk/d$b;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/d;->d:Ljava/io/File;

    .line 7
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/ndk/d$b;->e(Lcom/aliyun/emas/apm/crash/ndk/d$b;)Ljava/io/File;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/ndk/d;->e:Ljava/io/File;

    return-void
.end method

.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/ndk/d$b;Lcom/aliyun/emas/apm/crash/ndk/d$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/ndk/d;-><init>(Lcom/aliyun/emas/apm/crash/ndk/d$b;)V

    return-void
.end method
