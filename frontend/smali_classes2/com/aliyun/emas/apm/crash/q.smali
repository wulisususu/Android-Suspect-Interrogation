.class public abstract Lcom/aliyun/emas/apm/crash/q;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;Ljava/lang/String;Ljava/io/File;)Lcom/aliyun/emas/apm/crash/q;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/c;

    invoke-direct {v0, p0, p1, p2}, Lcom/aliyun/emas/apm/crash/c;-><init>(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;Ljava/lang/String;Ljava/io/File;)V

    return-object v0
.end method


# virtual methods
.method public abstract a()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
.end method

.method public abstract b()Ljava/io/File;
.end method

.method public abstract c()Ljava/lang/String;
.end method
