.class public interface abstract Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;
.super Ljava/lang/Object;
.source "SourceFile"


# virtual methods
.method public abstract getSessionFileProvider(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;
.end method

.method public abstract hasCrashDataForCurrentSession()Z
.end method

.method public abstract hasCrashDataForSession(Ljava/lang/String;)Z
.end method

.method public abstract prepareNativeSession(Ljava/lang/String;)V
.end method
