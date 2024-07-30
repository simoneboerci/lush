abstract interface class Repository<E, M> {
  E toEntity(M model);
  M toModel(E entity);
}
