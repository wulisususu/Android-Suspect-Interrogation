.class final Lcom/aliyun/emas/apm/crash/internal/model/z$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/z;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;
    .locals 4

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/z;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/z$b;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/z$b;->b:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/z;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/model/z$a;)V

    return-object v0
.end method

.method public setId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/z$b;->a:Ljava/lang/String;

    return-object p0
.end method

.method public setNick(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/z$b;->b:Ljava/lang/String;

    return-object p0
.end method
