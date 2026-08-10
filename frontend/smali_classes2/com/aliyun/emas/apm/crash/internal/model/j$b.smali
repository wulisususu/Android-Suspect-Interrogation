.class final Lcom/aliyun/emas/apm/crash/internal/model/j$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/j;
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
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;
    .locals 4

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/j;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/j$b;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/j$b;->b:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/j;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/model/j$a;)V

    return-object v0
.end method

.method public setAccess(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/j$b;->b:Ljava/lang/String;

    return-object p0
.end method

.method public setCarrier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/j$b;->a:Ljava/lang/String;

    return-object p0
.end method
